class Hito < Sprite
    @@hitos = []

    def initialize() #キャラクタの初期化
        # SPEEEEEEED
        @speed = 5
        # 画像
        img = Image.new(50, 50, [200, 1, 1])
        # スプライト(キャラクターの中身)
        return super(rand(0..(Window.width - img.width)),rand(0..(Window.height - img.height)), img)
    end

    def move() #移動系
        self.draw()
    end

    def self.auto_generate()
        #3%の確立で増殖
        if (0..1) === rand(50)
            @@hitos << Hito.new() #後ろに追加する
        end
        @@hitos.each do |h|
            h.move()
        end
    end

    def self.hitos()
        return @@hitos
    end

end