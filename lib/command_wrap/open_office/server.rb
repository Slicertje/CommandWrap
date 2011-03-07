module CommandWrap::OpenOffice

    module Server

        def self.start
            pid1 = fork do
                exec CommandWrap::Config::OpenOffice.xvfb
            end
            sleep 5 # 5 seconden wachten tot xvfb draait
            pid2 = fork do
                exec CommandWrap::Config::OpenOffice.command
            end
        end

        def self.stop
            `#{CommandWrap::Config::OpenOffice.stop_xvfb}`
            sleep 5
            `#{CommandWrap::Config::OpenOffice.stop}`
        end

        def self.restart
            stop
            sleep 5
            start
        end

    end

end