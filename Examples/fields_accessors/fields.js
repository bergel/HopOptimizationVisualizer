"use hopscript";


let o = {
    set x( value ) { this.internX = value; },
    get x() { return this.interX; }
}


function test( n, m ) {
  let acc = 0;
  const k = n / 10;

  o.e = 5;
  o.f = 6;

  for( let i = 0; i < n; i++ ) {

     if( i % k === 0 ) console.log( i );

     for( let j = 0; j < m; j++ ) {
	 o.x = j;
	 acc += o.x;
     }
  }

  return acc;
}


console.log( test( 1000, 10000 ) );
