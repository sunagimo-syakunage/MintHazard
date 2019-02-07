class Enemyc < Sprite
    @@enemies = []

    def initialize() #キャラクタの初期化
        #エネミー用関数
        
        # SPEEEEEEED
        @speed = 5
        # 画像
        # img = Image.load('./image/enemyc.png')
        # Image.register(:enemyc, './image/enemyc.png')
        # img = Image.load('./image/enemy.png')
        img = Image[:enemyc]
        # スプライト(キャラクターの中身)
        return super(rand(0..(Window.width - img.width)),rand(0..(Window.height - img.height)), img)
    end

    def move() #移動系
        self.draw()
    end

    def self.auto_generate()
        #3%の確立で増殖
        if (0..1) === rand(1000)

            @@enemies << Enemyc.new() #後ろに追加する
        end
        @@enemies.each do |e|
            e.move()
        end
    end

    def self.enemies()
        return @@enemies
    end

end