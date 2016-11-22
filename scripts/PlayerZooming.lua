--
--
-- Player Zooming - change FOV on the fly
--
--
-- Version: 0.1
-- Date: 11.11.2016
-- Author: WKF Modding
--
--

PlayerCamera = {};

function PlayerCamera:loadMap(name)
    if self.initialized then
        return;
    end;
	self.fovAngle = 60;
    self.newFovy = 60;
    self.acceleration = 0.5;
    self.step = 5;
    self.initialized = true;
    self.uf = false;
end;

function PlayerCamera:deleteMap()
    self.initialized = false;
end;

function PlayerCamera:delete()
end;

function PlayerCamera:update(dt)

	if(self.uf == true) then
		if(self.hore == true) then
			if(self.fovAngle > self.newFovy) then
				if(self.CameraPlayer == false) then
					self.fovAngle = getFovy(self.cameraId);
					setFovy(self.cameraId, self.fovAngle-self.acceleration);
				else
					self.fovAngle = getFovy(self.playerCamera);
					setFovy(self.playerCamera, self.fovAngle-self.acceleration);
				end;
			else
				self.uf = false;
			end;
		else
			if(self.fovAngle < self.newFovy) then
				if(self.CameraPlayer == false) then
					self.fovAngle = getFovy(self.cameraId);
					setFovy(self.cameraId, self.fovAngle+self.acceleration);
				else
					self.fovAngle = getFovy(self.playerCamera);
					setFovy(self.playerCamera, self.fovAngle+self.acceleration);
				end;
			else
				self.uf = false;
			end;
		end;
	end;
end;

function PlayerCamera:mouseEvent(posX, posY, isDown, isUp, button)

	if g_currentMission.controlledVehicle then
		self.CameraPlayer = false;
		self.cameraId = getCamera();
		self.newFovy = getFovy(self.cameraId);
		if self.cameraId ~= nil then
			if Input.isMouseButtonPressed(Input.MOUSE_BUTTON_RIGHT) then

				self.uf = true;
				self.fovAngle = getFovy(self.cameraId);

				if Input.isMouseButtonPressed(Input.MOUSE_BUTTON_WHEEL_UP) and self.fovAngle > 10 then
					self.hore = true;
					self.newFovy = self.fovAngle-self.step;
				end;
				if Input.isMouseButtonPressed(Input.MOUSE_BUTTON_WHEEL_DOWN) and self.fovAngle < 140 then
					self.hore = false;
					self.newFovy = self.fovAngle+self.step;
				end;
			end;
		else
			self.uf = false;
		end;
	end;

	if g_currentMission.controlPlayer then
		if(g_currentMission.player ~= nil)then
			self.CameraPlayer = true;

			self.playerCamera = g_currentMission.player.cameraNode;
			self.newFovy = getFovy(self.playerCamera);
			if Input.isMouseButtonPressed(Input.MOUSE_BUTTON_RIGHT) then
				self.uf = true;
				self.fovAngle = getFovy(self.playerCamera);

				if Input.isMouseButtonPressed(Input.MOUSE_BUTTON_WHEEL_UP) and self.fovAngle > 10 then
					self.hore = true;
					self.newFovy = self.fovAngle-self.step;
				end;

				if Input.isMouseButtonPressed(Input.MOUSE_BUTTON_WHEEL_DOWN) and self.fovAngle < 140 then		
					self.hore = false;
					self.newFovy = self.fovAngle+self.step;
				end;
			end;
		end;
	end;
end;

function PlayerCamera:keyEvent(unicode, sym, modifier, isDown)
end;

function PlayerCamera:draw()
end;

addModEventListener(PlayerCamera);

print("-------------------------------------------------------------------------------------------")
print("PlayerZooming loaded. Right click and hold and use scroll wheel up/down to change FOV/zoom.");
print("-------------------------------------------------------------------------------------------")