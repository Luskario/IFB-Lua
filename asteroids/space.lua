Space = {}
MetaSpace = {}
MetaSpace.__index = Space

function colidindo(aX, aY, aRaio, bX, bY, bRaio)
    return (aX - bX)^2 + (aY - bY)^2 <= (aRaio + bRaio)^2
end

function Space.new(width, height)
    instance = setmetatable({}, MetaSpace)
    instance.width = width
    instance.height = height
    instance.asteroidSize = 40
    instance.asteroidTimeSpawn = 5
    instance.asteroids = {
        { x = 100, y = 100 },
        { x = width - 100, y = 100 },
        { x = width / 2, y = height - 100 }
    }
    
    instance.asteroidTipos = {
        { velocidade = 100, raio = 15 },
        { velocidade = 80, raio = 35 },
        { velocidade = 50, raio = 50 }
    }

    for asteroidIndex, asteroid in ipairs(instance.asteroids) do
        asteroid.angulo = love.math.random() * (2 * math.pi)
        asteroid.tipo = #instance.asteroidTipos
    end

    return instance
end

function Space:asteroidMove(dt, nave)
    -- Realiza a movimentação dos asteroides e verifica colisão com a nave --
    for Index, asteroid in ipairs(self.asteroids) do
        asteroid.x = (asteroid.x + math.cos(asteroid.angulo) * self.asteroidTipos[asteroid.tipo].velocidade * dt) % self.width
        asteroid.y = (asteroid.y + math.sin(asteroid.angulo) * self.asteroidTipos[asteroid.tipo].velocidade * dt) % self.width

        if colidindo(nave.x, nave.y, nave.raio, asteroid.x, asteroid.y, self.asteroidTipos[asteroid.tipo].raio) then
            love.load()
            break
        end
    end
end

function Space:asteroidSpawner(dt)
    -- Spawna um novo asteroide em um local aleatorio no canto do mapa --
    self.asteroidTimeSpawn = self.asteroidTimeSpawn - dt
    local angulo = love.math.random() * (2 * math.pi)
    local tipo = love.math.random(1, 3)
    local posicoes = {
        {def=self.height, ndef=self.width}, 
        {def=0, ndef=self.width}, 
        {def=self.width, ndef=self.height}, 
        {def=0, ndef=self.height}
    }
    local pos = love.math.random(1, 4)
    local definido = love.math.random(posicoes[pos].ndef)

    if self.asteroidTimeSpawn < 1 and #self.asteroids < 10 then
        if pos < 2 then
            table.insert(self.asteroids, { x = definido, y = posicoes[pos].def, angulo = angulo, tipo = tipo})
        else
            table.insert(self.asteroids, { x = posicoes[pos].def, y = definido, angulo = angulo, tipo = tipo})
        end

        self.asteroidTimeSpawn = 5
    end
end


function Space:asteroidBulletColisao(nave)
    -- Verifica a colisão das balas com o asteroide --
    for bIndex = #nave.bullets, 1, -1 do
        local bullet = nave.bullets[bIndex]
        
        for Index = #self.asteroids, 1, -1 do
            local asteroid = self.asteroids[Index]

            if colidindo(bullet.x, bullet.y, 5, asteroid.x, asteroid.y, self.asteroidTipos[asteroid.tipo].raio) then
                table.remove(nave.bullets, bIndex)

                if asteroid.tipo > 1 then

                    local angulo = love.math.random() * (2 * math.pi)
                    local angulo1 = love.math.random() * (2 * math.pi)

                    table.insert(self.asteroids, { x = asteroid.x, y = asteroid.y, angulo = angulo, tipo = asteroid.tipo - 1})
                    table.insert(self.asteroids, { x = asteroid.x, y = asteroid.y, angulo = angulo1, tipo = asteroid.tipo - 1})
                
                end
                -- Adiciona pontos ao jogador destruir o asteoroid
                nave.points = nave.points + 1
                
                table.remove(self.asteroids, Index)
                break
            end
        end
    end
end

function Space:draw()

    for y = -1, 1 do
        for x = -1, 1 do
            for Index, asteroid in ipairs(self.asteroids) do
                love.graphics.setColor(1, 0, 1)
                love.graphics.circle('fill', asteroid.x, asteroid.y, self.asteroidTipos[asteroid.tipo].raio)
            end
        end
    end
    
end

