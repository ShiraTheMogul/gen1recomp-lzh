return function(mod)

  -- Presentation-only source strings authored by Lua rather than ROM text so it doesnt explode
  mod.content.strings:override("Enemy %s", "敵%s")
  mod.content.strings:override("PROF.OAK", "大木博士")
  mod.content.strings:override("OLD MAN", "老人")

  mod.content.font:register("ttf", {
    file = "assets/fonts/wenjin-mincho/WenJinMinchoP0-Regular.ttf",
    size = 16,
    tiles = "0123456789",
    advances = {
      ["，"] = 8,
      ["。"] = 8,
      ["、"] = 8,
      ["；"] = 8,
      ["："] = 8,
      ["！"] = 8,
      ["？"] = 8,
    },
  })

end
