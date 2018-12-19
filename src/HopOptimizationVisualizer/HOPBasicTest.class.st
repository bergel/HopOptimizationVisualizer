Class {
	#name : #HOPBasicTest,
	#superclass : #HOPTest,
	#category : #HopOptimizationVisualizer
}

{ #category : #'as yet unclassified' }
HOPBasicTest >> exampleCacheAndLocationJSON [
"
Need to use the option
HOPTRACE=""hopscript:cache format:fprofile"" ./a.out 2> traceCache2.json
"

"
STONJSON fromString: self new exampleCacheAndLocationJSON
"

^ '{
"format": "fprofile",
"sources": [
  { "filename": "example.js",
    "caches": [
      { "point": -1, "usage": "-", "imap": 1, "emap": 1, "cmap": 1, "pmap": 1, "amap": 1, "vtable": 1 }, 
      { "point": 46, "usage": "put", "miss": 2, "emap": 25512228 }, 
      { "point": 62, "usage": "put", "emap": 25512229 }, 
      { "point": 306, "usage": "get", "imap": 24620200 }, 
      { "point": 326, "usage": "get", "imap": 24620200 }, 
      { "point": 648, "usage": "get", "imap": 34004 }, 
      { "point": 665, "usage": "get", "imap": 34004 }, 
      { "point": 1048, "usage": "get", "imap": 860024 }, 
      { "point": 1320, "usage": "get", "imap": 24 }, 
      { "point": 1353, "usage": "get", "imap": 24 }, 
      { "point": -1 } ]
  },
  { "filename": "", "caches": [] }
],
"config": {
  "tmp": "/tmp/alexandrebergel/J2S/example.js",
  "optim-callapply": true,
  "optim-clevel": true,
  "optim-tyflow": true,
  "optim-multivar": true,
  "optim-cinstanceof": true,
  "optim-tyflow-resolve": true,
  "optim-unletrec": true,
  "optim-letopt": true,
  "optim-method": true,
  "optim-pce": true,
  "optim-vector": true,
  "optim-ctor": true,
  "optim-range": true,
  "optim-hintnum": true,
  "optim-hint": true,
  "optim-array": true,
  "optim-literals": true,
  "optim-inline": true,
  "optim-integer": true,
  "profile-method": true,
  "profile-hint": true,
  "profile-cache": true,
  "profile-call": true,
  "commonjs-export": true,
  "return-as-exit": false,
  "filename": "example.js",
  "driver-name": "j2s-optim-driver",
  "worker": true,
  "worker-slave": false,
  "module-main": true,
  "module-name": "example",
  "module-path": false,
  "hopscript-header": true,
  "type-annotations": false,
  "optim": 1000,
  "verbose": 2,
  "long-size": 64,
  "int-size": 61,
  "plugins-loader": false,
  "debug": 0,
  "optim-ccall": true,
  "profile": true,
  "es6-let": true,
  "es6-const": true,
  "es6-arrow-function": true,
  "es6-default-value": true,
  "es6-rest-argument": true,
  "es2017-async": true,
  "debug-client": 0
},
"run": {
  "commandline": "./a.out",
  "date": "Wed Dec 19 07:45:14 2018"
  }
}
'
]

{ #category : #'as yet unclassified' }
HOPBasicTest >> exampleJS [

^ '
"use strict";

function Cons( a, d ) {
  this.car = a;
  this.cdr = d;
}

function interval( min, max ) {
  if( min > max ) {
     return null;
  } else {
     return new Cons( min, interval( min + 1, max ) );
  }
}

function sfilter( p, l ) {
  if( l === null ) {
     return l;
  } else {
     let a = l.car;
     let r = l.cdr;

     if( p( a ) ) {
	 return new Cons( a, sfilter( p, r ) );
     } else {
	 return sfilter( p, r );
     }
  }
}

function remove_multiples_of( n, l ) {
  return sfilter( m => (m % n) != 0, l );
}

function sieve( max ) {
  function filter_again( l ) {
     if( l === null ) {
	 return l;
     } else {
	 let n = l.car;
	 let r = l.cdr;

	 if( n * n > max ) {
	    return l;
	 } else {
	    return new Cons( n, filter_again( remove_multiples_of( n, r ) ) );
	 }
     }
  }
  return filter_again( interval( 2, max ) );
}

function do_list( f, lst ) {
  while( lst !== null ) {
     f( lst.car );
     lst = lst.cdr;
  }
}

function length( lst ) {
  let res = 0;

  while( lst != null ) {
     res++;
     lst = lst.cdr;
  }

  return res;
}

function doit( num ) {
  let res = 0;

  while( num-- > 0 ) {
     res += length( sieve( 3000 ) );
  }

  return res;
}

function list2array( lst ) {
  let len = length( lst );
  var res = new Array( len );

  for( let i = 0; i < len; lst = lst.cdr, i++ ) {
     res[ i ] = lst.car;
  }

  return res;
}

const expected_result = [
  2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31,
  37, 41, 43, 47, 53, 59, 61, 67, 71, 73,
  79, 83, 89, 97 ];

function main() {
  let s100 = sieve( 100 );
  let n = 2000;

  doit( n );
  console.log( list2array( s100 ) );
}

main();'
]

{ #category : #'as yet unclassified' }
HOPBasicTest >> exampleJSON [

"This JSON has been obtained by executing:

hopc --profile -Ox -v2 example.js
HOPTRACE=""hopscript:cache format:json"" ./a.out 2> traceCache.json

"

^ '{
"format": "json",
"caches": {
  "accesses": 101192956,
  "hits": 101192937,
  "misses": 19,
  "multis": 0,
  "uncaches": {
    "total": 0,
    "get": 0,
    "put": 0,
    "call": 91
  },
  "imap": {
    "get": {
      "total": 50168480,
      "entries": [
        { "cdr": 25514252 }, 
        { "car": 24654228 }, 
        -1 ]
    },
    "put": {
      "total": 0,
      "entries": [
        -1 ]
    },
    "call": {
      "total": 0,
      "entries": [
        -1 ]
    }
  },
  "emap": {
    "get": {
      "total": 0,
      "entries": [
        -1 ]
    },
    "put": {
      "total": 51024457,
      "entries": [
        { "cdr": 25512229 }, 
        { "car": 25512228 }, 
        -1 ]
    },
    "call": {
      "total": 0,
      "entries": [
        -1 ]
    }
  },
  "cmap": {
    "get": {
      "total": 0,
      "entries": [
        -1 ]
    },
    "put": {
      "total": 0,
      "entries": [
        -1 ]
    },
    "call": {
      "total": 0,
      "entries": [
        -1 ]
    }
  },
  "pmap": {
    "get": {
      "total": 0,
      "entries": [
        -1 ]
    },
    "put": {
      "total": 0,
      "entries": [
        -1 ]
    },
    "call": {
      "total": 0,
      "entries": [
        -1 ]
    }
  },
  "amap": {
    "get": {
      "total": 0,
      "entries": [
        -1 ]
    },
    "put": {
      "total": 0,
      "entries": [
        -1 ]
    },
    "call": {
      "total": 0,
      "entries": [
        -1 ]
    }
  },
  "vtable": {
    "get": {
      "total": 0,
      "entries": [
        -1 ]
    },
    "put": {
      "total": 0,
      "entries": [
        -1 ]
    },
    "call": {
      "total": 0,
      "entries": [
        -1 ]
    }
  },
  "hclasses": 101164,
  "invalidations": 132,
  "vtables": { "number": 0, "mem": 0, "locations": 0, "degree":0, "conflicts":0}
},
"config": {
  "tmp": "/tmp/alexandrebergel/J2S/example.js",
  "optim-callapply": true,
  "optim-clevel": true,
  "optim-tyflow": true,
  "optim-multivar": true,
  "optim-cinstanceof": true,
  "optim-tyflow-resolve": true,
  "optim-unletrec": true,
  "optim-letopt": true,
  "optim-method": true,
  "optim-pce": true,
  "optim-vector": true,
  "optim-ctor": true,
  "optim-range": true,
  "optim-hintnum": true,
  "optim-hint": true,
  "optim-array": true,
  "optim-literals": true,
  "optim-inline": true,
  "optim-integer": true,
  "profile-method": true,
  "profile-hint": true,
  "profile-cache": true,
  "profile-call": true,
  "commonjs-export": true,
  "return-as-exit": false,
  "filename": "example.js",
  "driver-name": "j2s-optim-driver",
  "worker": true,
  "worker-slave": false,
  "module-main": true,
  "module-name": "example",
  "module-path": false,
  "hopscript-header": true,
  "type-annotations": false,
  "optim": 1000,
  "verbose": 2,
  "long-size": 64,
  "int-size": 61,
  "plugins-loader": false,
  "debug": 0,
  "optim-ccall": true,
  "profile": true,
  "es6-let": true,
  "es6-const": true,
  "es6-arrow-function": true,
  "es6-default-value": true,
  "es6-rest-argument": true,
  "es2017-async": true,
  "debug-client": 0
},
"run": {
  "commandline": "./a.out",
  "date": "Wed Dec 19 07:29:14 2018"
  }
}
'
]

{ #category : #tests }
HOPBasicTest >> testBasic [ 

	HOPVisualizer new openOnJSSource: HOPBasicTest new exampleJS cacheSource: HOPBasicTest new exampleCacheAndLocationJSON
]
