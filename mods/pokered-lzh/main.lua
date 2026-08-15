return function(mod)

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
