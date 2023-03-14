areacilindro :: Float -> Float -> Float 
areacilindro r h = 
    let arealado = 2 * pi * r * h;
        areabase = pi * r * r
    in arealado + 2 * areabase 
