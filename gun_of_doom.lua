///Description
SWEP.PrintName = "Gun of DOOM" -- The name of the weapon    
SWEP.Author = "RandomEngie5" -- The name of the author
SWEP.Purpose = "Kill anyone in the way" -- The purpose of the weapon
SWEP.Instructions = "Left click to fire" -- How to use the weapon
SWEP.Category = "Other" --This is required or else your weapon will be placed under "Other"

///spawn settings
SWEP.Spawnable= true --Must be true
SWEP.AdminOnly = true --Only Admins can spawn it

///Properties
SWEP.Base = "weapon_base"
local ShootSound = Sound("Weapon_Pistol.Single")
SWEP.Primary.Damage = 50 --The amount of damage will the weapon do
SWEP.Primary.TakeAmmo = 1 -- How much ammo will be taken per shot
SWEP.Primary.ClipSize = 100  -- How much bullets are in the mag
SWEP.Primary.Ammo = "Shotgun" --The ammo type will it use
SWEP.Primary.DefaultClip = 50 -- How much bullets preloaded when spawned
SWEP.Primary.Spread = 0.5 -- The spread when shot
SWEP.Primary.NumberofShots = 30 -- Number of bullets when shot
SWEP.Primary.Automatic = true -- Is it automatic
SWEP.Primary.Recoil = .1 -- The amount of recoil
SWEP.Primary.Delay = 0 -- Delay before the next shot
SWEP.Primary.Force = 100

///Secondary Attack
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

///Slot settings
SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.DrawCrosshair = true --Does it draw the crosshair
SWEP.DrawAmmo = true
SWEP.Weight = 5 --Priority when the weapon your currently holding drops
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

///Misc settings
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 60
SWEP.ViewModel			= "models/weapons/c_pistol.mdl"
SWEP.WorldModel			= "models/weapons/w_pistol.mdl"
SWEP.UseHands           = true

SWEP.HoldType = "SMG" 

SWEP.FiresUnderwater = true

SWEP.ReloadSound = "sound/epicreload.wav"

SWEP.CSMuzzleFlashes = false

///Initializer
function SWEP:Initialize()
util.PrecacheSound(ShootSound) 
util.PrecacheSound(self.ReloadSound) 
self:SetWeaponHoldType( self.HoldType )
end 

///Primary Attack
function SWEP:PrimaryAttack()
 
if ( !self:CanPrimaryAttack() ) then return end
 
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
bullet.Tracer = 1
bullet.Force = self.Primary.Force 
bullet.Damage = self.Primary.Damage 
bullet.AmmoType = self.Primary.Ammo 
 
local rnda = self.Primary.Recoil * -1 
local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self:EmitSound(ShootSound)
self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
 
self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
end 

///Secondary Attack
function SWEP:SecondaryAttack()
end

///Reload sounds
function SWEP:Reload()
self:EmitSound(Sound(self.ReloadSound)) 
        self.Weapon:DefaultReload( ACT_VM_RELOAD );
end