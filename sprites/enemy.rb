class Enemy < Sprite
    @@enemies = []

    def initialize() #キャラクタの初期化
        #エネミー用関数
        
        # SPEEEEEEED
        @speed = 5
        # 画像
        Image.register(:enemy, './image/enemy.png')
        # img = Image.load('./image/enemy.png')
        img = Image[:enemy]
        # スプライト(キャラクターの中身)
        return super(rand(0..(Window.width - img.width)),rand(0..(Window.height - img.height)), img)
    end

    def move() #移動系
        self.draw()
    end

    def self.auto_generate()
        #3%の確立で増殖
        if (0..3) === rand(100)

            @@enemies << Enemy.new() #後ろに追加する
        end
        @@enemies.each do |e|
            e.move()
        end
    end

    def self.enemies()
        return @@enemies
    end

end