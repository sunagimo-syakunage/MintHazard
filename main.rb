require "dxopal"
include DXOpal


# image = Image.load('./image/logo.png')
# image2 = Image.load('./image/backscreen.png')
# image3 = Image.load('./image/mig.png')
Image.register(:logo, './image/logo.png')
Image.register(:backscreen, './image/backscreen.png')
Image.register(:mig, './image/mig.png')
Image.register(:player, './image/pointer.png')
Image.register(:enemy, './image/enemy.png')
Image.register(:enemyb, './image/enemyb.png')
Image.register(:enemyc, './image/enemyc.png')

require_remote "./sprites/main_character.rb"
require_remote "./sprites/enemy.rb"
require_remote "./sprites/enemyb.rb"
require_remote "./sprites/enemyc.rb"
require_remote "./sprites/timer.rb"




Window.load_resources do
  # 準備系
  scene = "title"
  font = Font.new(32)

  # 背景色
  Window.bgcolor = [255, 161, 89]

  # 横幅*高さ
  Window.width = 500
  Window.height = 500

  # フォント
  fx = 0
  fy = 0
  sfont = Font.new(64)

  z = 0

  limit_time = 60  # 分*60
  start_time = 0
  tx = 0
  ty = 42

  # キャラクター
  character = MainCharacter.new()
  #実際のゲーム画面始まり
Window.loop do
    case scene
    when "title" # タイトル画面
      Window.draw_scale( 25, 25, Image[:backscreen], 1.2,1.2, centerx=nil, centery=nil, z=0)
      Window.draw_scale( -140, -50, Image[:logo], 0.7, 0.7, centerx=nil, centery=nil, z=0 )
      Window.draw_font(100, 250, "制限時間以内に", font)
      Window.draw_font(100, 300, "クリックで敵を倒そう", font)
      Window.draw_font(130, 450, "クリックでスタート", font)
      if Input.mouse_push?( M_LBUTTON )
        z=1
        start_time = Time.now
      scene = "main"
      end
    when "main" # メイン画面
      Window.draw( 0, 0, Image[:mig])
      # Input.mouse_enable=false
      character.move()
      Enemy.auto_generate()
      Enemyb.auto_generate()
      Enemyc.auto_generate()
      Window.draw_font(fx, fy, "Score:#{$score}", font)
      if z == 1
      now_time = Time.now
	    diff_time = now_time - start_time
      countdown = (limit_time - diff_time).to_i
	    sec = countdown % 60
      Window.draw_font(tx, ty, "Time :#{sec}", font)
      end
      scene = "gameover" if sec == 0
    when "gameover" # ゲームオーバー画面
      Window.draw_scale( 25, 25, Image[:backscreen], 1.2,1.2, centerx=nil, centery=nil, z=0)
      Window.draw_font(155, 100, "GAME OVER!", font)
      Window.draw_font(100, 200, "Score:#{$score}", sfont)
      Window.draw_font(155, 450, "クリックで戻る", font)
      if Input.mouse_push?( M_LBUTTON )
        $score = 0
        Enemy.enemies().each do |e|
          e.vanish()
        end
        Enemyb.enemies().each do |eb|
          eb.vanish()
        end
        Enemyc.enemies().each do |ec|
          ec.vanish()
        end
        Sprite.clean(Enemy.enemies())
        Sprite.clean(Enemyb.enemies())
        Sprite.clean(Enemyc.enemies())
        z = 0
        limit_time = 60
        scene = "title"
    end
  end

    break if Input.key_push?(K_ESCAPE)
end
end
