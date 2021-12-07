shader_type spatial;
uniform float speed = 4.0;
uniform float dis = 0.7;

void vertex(){
	VERTEX.x += sin(TIME * speed) * dis * (UV.y-1.0);
}