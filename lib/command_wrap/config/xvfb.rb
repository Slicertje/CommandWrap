module CommandWrap::Config

    module Xvfb

        def self.executable
            @executable ||= "xvfb-run"
        end

        def self.executable= (executeable)
            @executable = executeable
        end

        def self.params
            @params ||= '--wait=0 --server-args="-screen 0, 1024x768x24"'
        end

        def self.params= (params)
            @params = params
        end

        def self.command (subcommand)
            if server_mode
                "DISPLAY=:#{server_port};#{subcommand}"
            else
                "#{executable} #{params} #{subcommand}"
            end
        end

        def self.server_mode
            if @server_mode.nil?
                @server_mode = false
            end
            @server_mode
        end

        def self.server_mode= (server_mode)
            @server_mode = server_mode
        end

        def self.server_port
            @server_port ||= '35'
        end

        def self.server_port= (server_port)
            @server_port = server_port
        end

        def self.server_command
            @server_command ||= 'Xvfb :35 -screen 0 1024x768x24'
        end

        def self.server_command= (server_command)
            @server_command = server_command
        end

        def self.stop_server_command
            @server_stop ||= "killall -9 Xvfb"
        end

        def self.stop_server_command= (server_stop)
            @server_stop = server_stop
        end

    end

end