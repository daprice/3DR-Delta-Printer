so=0.01;
er=3;
module nemSel(n=17,l){
if(n==17) nema(s=42.2,l=38,dh=15.5);
if(n==14) nema(s=35.2,l=28,dh=13);
if(n==11) nema(s=28.3,l=44,dh=11.5);
}
module nema(s=42.2,l=38,dh=15.5){
	color("silver") translate([0,0,l/2])shaft();
	color("silver") translate([0,0,l/4]) nemcov(sc=s,lc=l,dc=dh);	
	color("black")translate([-(s-er/sqrt(2))/2,-(s-er/sqrt(2))/2,-l/4])
		cube([s-er/sqrt(2),s-er/sqrt(2),l/2]);
	color("silver") translate([0,0,-l/2]) nemcov(sc=s,lc=l,dc=0);
	
}

module nemcov(sc=42.2,lc=38,dc=15.5,lh=10,num){
	difference(){
		translate([-sc/2,-sc/2,0])cube([sc,sc,lc/4]);
		for(i=[0:3]){
			rotate(90*i){
				translate([sc/2,sc/2-er/sqrt(2),-so]) rotate(45)
					cube([er,er,lc/4+2*so]);
				if(dc>0) translate([dc,dc,lc/4-5])
				 cylinder(r=1.5,h=5+so,$fn=30);
			}
		}
	}
	if(dc<0) for(i=num){
		rotate(90*i) hull(){			
			translate([dc,dc,lc/4])
				cylinder(r=1.5,h=lh,$fn=30);
			translate([dc-2,dc-2,lc/4])
				cylinder(r=1.5,h=lh,$fn=30);	
		}
	}
}

module shaft(){
	cylinder(r=11,h=2,$fn=30);
	translate([0,0,2]) cylinder(r=2.5,h=24,$fn=30);
}
/*nemcov(dc=-15.5,lh=15,num=[0,1]);
nemcov(dc=-15.5,lh=10,num=[2,3]);*/

