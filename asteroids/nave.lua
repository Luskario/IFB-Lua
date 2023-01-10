Nave = {}
MetaNave = {}
MetaNave.__index = Nave

function Nave.new(x, y, angulo, color, velAngulo, velNave)
    instance = setmetatable({}, MetaNave)
    instance.x = x
    instance.y = y
    instance.velX = 0
    instance.velY = 0
    instance.angulo = angulo
    instance.color = color
    instance.velAngulo = velAngulo
    instance.velNave = velNave
    instance.raio = 20
    instance.points = 0
    instance.bullets = {}
    instance.tempBulletsLimite = 0.5
    instance.tempBullets = instance.tempBulletsLimite

    return instance
end


function Nave:rotate(key, dt)
    if key == 'right' then
        self.angulo = self.angulo + self.velAngulo * dt
    end
    if key == 'left' then
        self.angulo = self.angulo - self.velAngulo * dt
    end
end

function Nave:move(key, dt)
    if key == 'up' then
        self.velX =  self.velX + math.cos(self.angulo) * self.velNave * dt
        self.velY =  self.velY + math.sin(self.angulo) * self.velNave * dt
    end
end

function Nave:stats(dt, w, h)

    -- Atualiza os status da nave --
    self.tempBullets = self.tempBullets + dt
    self.angulo = self.angulo % (2* math.pi)
    self.x = (self.x + self.velX * dt) % w
    self.y = (self.y + self.velY * dt) % h

    -- Limita a Velocidade da nave --
    if self.velX > 100 then self.velX = 100
    end
    if self.velX < -100 then self.velX = -100
    end
    if self.velY > 100 then self.velY = 100
    end
    if self.velY < -100 then self.velY = -100
    end

    for Index = #self.bullets, 1, -1 do
        -- Atualiza a posição das balas e as apagas após exceder seu tempo de vida -- 
        local bullet = self.bullets[Index]
        bullet.tempo = bullet.tempo - dt

        if bullet.tempo <= 0 then
            table.remove(self.bullets, Index)
        else
            local velBullet = 500
            bullet.x = (bullet.x + math.cos(bullet.angulo) * velBullet * dt) % w
            bullet.y = (bullet.y + math.sin(bullet.angulo) * velBullet * dt) % h
        end
    end
end

function Nave:shot()
    -- Atira as balas da nave --
    if self.tempBullets >= self.tempBulletsLimite then
        self.tempBullets = 0
        table.insert( self.bullets, {
            x = self.x + math.cos(self.angulo) * self.raio,
            y = self.y + math.sin(self.angulo) * self.raio,
            angulo = self.angulo, tempo = 4
        })
    end
end

function Nave:stop(dt)
    -- Reduz a velocidade da nave --
    if self.velX > 0 then
        self.velX =  self.velX - self.velNave * dt
    else
        self.velX = self.velX + self.velNave * dt
    end
    if self.velY > 0 then
        self.velY =  self.velY - self.velNave * dt
    else
        self.velY = self.velY + self.velNave * dt
    end

end

function Nave:draw(w, h)

    for y = -1, 1 do
        for x = -1, 1 do
            love.graphics.origin()
            love.graphics.translate(x * w, y * h)

            love.graphics.setColor(self.color[1], self.color[2], self.color[3])
            love.graphics.polygon('fill', self.x + math.cos(self.angulo) * self.raio, 
                self.y + math.sin(self.angulo) * self.raio,
                self.x + math.cos(self.angulo+90) * self.raio, 
                self.y + math.sin(self.angulo+90) * self.raio,
                self.x + math.cos(self.angulo-90) * self.raio, 
                self.y + math.sin(self.angulo-90) * self.raio
            )

            love.graphics.setColor(0, 1, 1)
            love.graphics.circle('fill', self.x + math.cos(self.angulo) * self.raio, self.y + math.sin(self.angulo) * self.raio, 5)

            for bulletIndex, bullet in ipairs(self.bullets) do
                love.graphics.setColor(0, 1, 1)
                love.graphics.circle('fill', bullet.x, bullet.y, 5)
            end
        end
    end
    love.graphics.origin()
end