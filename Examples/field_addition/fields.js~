"use hopscript";


function CTOR( a, b, c, d ) {
  this.a = a;
  this.b = b;
  this.c = c;
  this.d = d;
  this.e = 0;
  this.f = 1;
}


function test( n, m ) {
  let acc = 0;
  const o = new CTOR( 1, 2, 3, 4 );
  const k = n / 10;

  o.e = 5;
  o.f = 6;

  for( let i = 0; i < n; i++ ) {

     if( i % k === 0 ) console.log( i );

     for( let j = 0; j < m; j++ ) {
	 acc = o.e + o.f;
     }
  }

  return acc;
}


console.log( test( 10000, 10000 ) );
