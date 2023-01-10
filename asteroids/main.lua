require("nave")
require("space")
local record = 0
local menu = true

function love.load()
    -- Carrega as variaveis e inicia o jogo --
    space = Space.new(800, 600)
    nave = Nave.new(400, 300, 0, {1, 0, 0}, 5, 100)
    love.window.setMode( 800, 600)
    menu = true
    
    
end

function love.update(dt)
    -- Atualiza e verifica os eventos do jogo --
    if menu == false then
        if nave.points > record then
            record = nave.points
        end

        if love.keyboard.isDown('right') then
            nave:rotate('right', dt)
        end
        if love.keyboard.isDown('left') then
            nave:rotate('left', dt)
        end
        if love.keyboard.isDown('up') then
            nave:move('up', dt)
        end
        if love.keyboard.isDown('down') then
            nave:stop(dt)
        end
        if love.keyboard.isDown('d') then
            nave:shot()
        
        end

        nave:stats(dt, space.width, space.height)
        space:asteroidMove(dt, nave)
        space:asteroidBulletColisao(nave)
        space:asteroidSpawner(dt)
    end
    
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == 'space' then
        menu = false
    end
end

function love.draw()
    -- Imprime os objetos e informações na tela --
    if menu == false then
        nave:draw(space.width, space.height)
        space:draw()
        love.graphics.setColor(1, 1, 0)
        love.graphics.print(table.concat({
            'Pontos: '..nave.points,
            'Record: '..record,
        }, '\n'))
    else
        love.graphics.setColor(1, 1, 0)
        love.graphics.print(table.concat({
            'record: '.. record
        }, '\n'), 325, 250)
        love.graphics.print(table.concat({
            '--contoles--',
            'mover: setas',
            'atirar: d',
            '\n Aperte "Espaço" para iniciar'
        }, '\n'), 300, 400)
    end

end
