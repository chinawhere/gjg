_root = File.expand_path('../../', __FILE__)
_share = File.join(File.expand_path('../../../../', __FILE__), 'shared')
working_directory _root
pid File.join('/tmp', 'unicorn.pid')
stderr_path File.join(_share, 'log', 'unicorn_err.log')
stdout_path File.join(_share, 'log', 'unicorn_out.log')

listen "/tmp/unicorn.todo.socket"

worker_processes 2
timeout 30