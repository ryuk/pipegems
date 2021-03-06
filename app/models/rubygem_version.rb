require 'fileutils'
require 'erubis'

class RubygemVersion < ActiveRecord::Base
  belongs_to :rubygem
  has_many :rubygem_files, dependent: :destroy
  has_one :gem_file, dependent: :destroy

  delegate :user_id, to: :rubygem

  accepts_nested_attributes_for :rubygem_files, allow_destroy: true

  before_save :build!

  validates :version, presence: true, uniqueness: { scope: :rubygem_id }

  def build!
    assets = []

    gem_file = self.build_gem_file

    tmp_dir = "#{Dir.tmpdir}/#{rubygem.lib_name}/#{self.version}"
    lib_dir = "#{tmp_dir}/lib"
    js_dir  = "#{lib_dir}/assets/javascripts/"

    FileUtils.mkdir_p(js_dir)

    rubygem_files.each do |f|
      FileUtils.cp(f.file.path, "#{js_dir}/#{f.file_identifier}")
      assets << "lib/assets/javascripts/#{f.file_identifier}"
    end

    File.open "#{lib_dir}/#{rubygem.lib_name}.rb", 'w' do |f|
        f.write <<-eos
          require 'rails'

          module Pipe
            module #{rubygem.class_name}
              class Engine < ::Rails::Engine
              end
            end
          end
        eos
    end

    spec = Gem::Specification.new do |s|
      s.name     = rubygem.lib_name
      s.version  = self.version
      s.authors  = ['Sasha Koss']
      s.email    = 'koss@nocorp.me'
      s.homepage = 'http://github.com/kossnocorp/pipegems'

      s.summary     = 'Turn your .js to .gem'
      s.description = 'Turn your .js to .gem'
      s.files       = ["lib/#{rubygem.lib_name}.rb"] + assets

      s.add_dependency('rails', '~> 3.1.0')
    end

    File.open "#{tmp_dir}/#{rubygem.lib_name}.gemspec", 'w' do |f|
      f.write spec.to_ruby
    end

    Dir.chdir(tmp_dir)

    gem_file_path = `gem build #{rubygem.lib_name}.gemspec`.match(/File: (.+)$/)[1]

    gem_file.file = File.open(gem_file_path)
    gem_file.save
  end
end
