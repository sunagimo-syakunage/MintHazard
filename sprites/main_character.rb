class MainCharacter < Sprite


    def initialize() #キャラクタの初期化
        # score
        $score = 0
        #敵の体力
        @eb = 0
        @ec = 0
        # 画像

        img = Image[:player]
        # img = Image.load('./image/pointer.png')
        # スプライト(キャラクターの中身)
        return super((Window.width / 2) - (img.width / 2),(Window.height / 2) - (img.height / 2), img)
    end

    def move() #移動系
        self.draw()
        self.x = Input.mouse_pos_x - 15  # マウスカーソルのx座標
        self.y = Input.mouse_pos_y - 15
        self.shooting()
    end

    def shooting()
        if Input.mouse_push?( M_LBUTTON )
            #@bullet << Bullet.new(self.x, self.y)
            self.check(Enemy.enemies()).each do |e|
                e.vanish()
                $score += 100
            end
            self.check(Enemyb.enemies()).each do |eb|
                @eb += 1
                if @eb == 3
                eb.vanish()
                @eb = 0
                $score += 300
                end
            end
            self.check(Enemyc.enemies()).each do |ec|
                @ec += 1
                if @ec == 10
                ec.vanish()
                @ec = 0
                $score += 1000
                end
            end
        end
        MainCharacter.clean(Enemy.enemies())
        MainCharacter.clean(Enemyb.enemies())
        MainCharacter.clean(Enemyc.enemies())
    end

end
