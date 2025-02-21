t = Def.ActorFrame{}

    t[#t+1] = Def.Quad{
	    InitCommand=function(self)
		    self:FullScreen():draworder(1):smooth(1):diffuse(color("#b60013"))
	    end,
	    OnCommand=function(self)

    	end
    }
    
return t                                                        