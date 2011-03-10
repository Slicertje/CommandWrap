module CommandWrap::Xvfb

    module Server

        def self.start
            fork do
                exec CommandWrap::Config::Xvfb.server_command
            end
        end

        def self.stop
            `#{CommandWrap::Config::Xvfb.stop_server_command}`
        end

        def self.restart
            stop
            sleep 5
            start
        end

    end

end