# NOTE: only doing this in development as some production environments (Heroku)
# NOTE: are sensitive to local FS writes, and besides -- it's just not proper
# NOTE: to have a dev-mode tool do its thing in production.
if Rails.env.development?
  task :set_annotation_options do
    # You can override any of these by setting an environment variable of the
    # same name.
    Annotate.set_defaults(
      'routes'                  => 'true',
      'position_in_routes'      => 'before',
      'position_in_class'       => 'before',
      'show_foreign_keys'       => 'true',
      'show_indexes'            => 'true',
      'simple_indexes'          => 'true',
      'model_dir'               => 'app/models',
      'root_dir'                => '',
      'include_version'         => 'true',
      'require'                 => '',
      'exclude_tests'           => 'true',
      'ignore_model_sub_dir'    => 'false',
      'ignore_columns'          => 'false',
      'ignore_unknown_models'   => 'false',
      'hide_limit_column_types' => 'integer,boolean',
      'skip_on_db_migrate'      => 'false',
      'format_bare'             => 'true',
      'format_rdoc'             => 'false',
      'format_markdown'         => 'false',
      'sort'                    => 'false',
      'force'                   => 'false',
      'trace'                   => 'false',
      'wrapper_open'            => nil,
      'wrapper_close'           => nil,
    )
  end

  Annotate.load_tasks
end
