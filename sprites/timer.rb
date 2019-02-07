class Timer < Sprite

    def initialize()
        @font = Font.new(32)
        @limit_time = 60  # 分*60
        @start_time = Time.now   
        @tx = 0
        @ty = 42
    end

    def timer()
        now_time = Time.now
        diff_time = now_time - @start_time
        countdown = (@limit_time - diff_time).to_i
        $sec = countdown % 60
        self.drawFont(tx, ty, "Time :#{sec}", font)
    end
end 