shader_type canvas_item;
//uniform vec4 line_color : source_color = vec4(1);
uniform float thickness : hint_range(0,1) = 0.5;
uniform float softness : hint_range(0,1) = 0.0;
uniform vec4 color : source_color;
uniform vec4 outline_color : source_color;
uniform float outline_thickness : hint_range(0,1) = 0.0;
uniform float outline_softness : hint_range(0,1) = 0.0;




void fragment() {
	vec4 main_texture = texture(TEXTURE, UV);
	float alpha = texture(TEXTURE, UV).r;
	float outline = smoothstep(outline_thickness - outline_softness, outline_thickness + outline_softness, alpha);
	alpha = smoothstep(1.0 - thickness - softness, 1.0 - thickness + softness, alpha);
	main_texture.a =  alpha;	
	main_texture.rgb = vec3(255, 255, 255);
	main_texture.rgb = mix(outline_color.rgb, color.rgb, outline);
	COLOR = main_texture;
}
