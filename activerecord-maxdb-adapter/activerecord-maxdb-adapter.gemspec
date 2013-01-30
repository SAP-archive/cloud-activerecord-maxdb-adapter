# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name              = 'activerecord-maxdb-adapter'
  s.version           = '0.2'
  s.date              = '2012-11-08'

  s.platform = Gem::Platform.new([nil, "java", nil])
  s.rubyforge_project = %q{jruby-extras}

  s.summary     = "ActiveRecord adapter for SAP MaxDB."
  s.description = "ActiveRecord adapter for SAP MaxDB. Only for use with JRuby. Requires separate MaxDB JDBC driver."

  s.authors  = ["SAP AG"]
  s.email    = 'krum.bakalsky@sap.com'
  s.homepage = 'https://github.com/sapnwcloudlabs/activerecord-maxdb-adapter'
  s.require_paths = %w[lib]
  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.md LICENSE]

  # = MANIFEST =
  s.files = %w[
    LICENSE
    README.md
    Rakefile
    activerecord-maxdb-adapter.gemspec
    lib/active_record/connection_adapters/maxdb_adapter.rb
    lib/activerecord-maxdb-adapter.rb
    lib/arel/visitors/maxdb.rb
    lib/arjdbc/discover.rb
    lib/arjdbc/maxdb.rb
    lib/arjdbc/maxdb/adapter.rb
    lib/arjdbc/maxdb/connection_methods.rb            
  ]
  # = MANIFEST =

  s.test_files = s.files.select { |path| path =~ /^test\/.*test.*\.rb/ }

  s.add_dependency(%q<activerecord-jdbc-adapter>, [">= 1.0.0"])
  s.add_dependency(%q<jdbc-maxdb>, [">= 0.0.0"])

  s.rubygems_version = %q{1.3.7}
  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3
  end
end
