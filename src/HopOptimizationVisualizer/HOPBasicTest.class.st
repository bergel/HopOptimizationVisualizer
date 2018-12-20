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

{ #category : #'as yet unclassified' }
HOPBasicTest >> exampleRichardCacheAndLocationJSON [
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
  { "filename": "richards.js",
    "caches": [
      { "point": -1, "usage": "-", "imap": 1, "emap": 1, "cmap": 1, "pmap": 1, "amap": 1, "vtable": 1 }, 
      { "point": 1979, "usage": "get", "miss": 3, "pmap": 817 }, 
      { "point": 2133, "usage": "get", "miss": 3, "pmap": 817 }, 
      { "point": 2347, "usage": "get", "miss": 3, "pmap": 817 }, 
      { "point": 2565, "usage": "get", "miss": 3, "pmap": 817 }, 
      { "point": 2620, "usage": "get", "miss": 3, "pmap": 817 }, 
      { "point": 2672, "usage": "get", "miss": 2, "pmap": 818 }, 
      { "point": 2724, "usage": "get", "miss": 2, "pmap": 818 }, 
      { "point": 2752, "usage": "get", "imap": 819 }, 
      { "point": 2805, "usage": "get", "imap": 819 }, 
      { "point": 3699, "usage": "put", "miss": 3, "emap": 817 }, 
      { "point": 3721, "usage": "put", "miss": 3, "emap": 817 }, 
      { "point": 3742, "usage": "put", "miss": 3, "emap": 817 }, 
      { "point": 3783, "usage": "put", "miss": 3, "emap": 817 }, 
      { "point": 3802, "usage": "put", "miss": 3, "emap": 817 }, 
      { "point": 3827, "usage": "put", "miss": 3, "emap": 817 }, 
      { "point": 4401, "usage": "get", "miss": 3, "pmap": 817 }, 
      { "point": 4748, "usage": "get", "miss": 3, "pmap": 817 }, 
      { "point": 5101, "usage": "get", "miss": 4, "pmap": 1636 }, 
      { "point": 5437, "usage": "get", "miss": 3, "pmap": 1637 }, 
      { "point": 5824, "usage": "get", "miss": 3, "pmap": 817 }, 
      { "point": 5866, "usage": "get", "imap": 819 }, 
      { "point": 5877, "usage": "get", "miss": 3, "pmap": 817 }, 
      { "point": 6215, "usage": "put", "imap": 4919 }, 
      { "point": 6254, "usage": "get", "imap": 4919 }, 
      { "point": 6294, "usage": "put", "imap": 4919 }, 
      { "point": 6306, "usage": "get", "imap": 4919 }, 
      { "point": 6324, "usage": "get", "imap": 4919 }, 
      { "point": 6342, "usage": "get", "imap": 4919 }, 
      { "point": 6463, "usage": "put", "imap": 819 }, 
      { "point": 6481, "usage": "get", "imap": 819 }, 
      { "point": 6500, "usage": "get", "imap": 8751039 }, 
      { "point": 6534, "usage": "get", "imap": 8750219 }, 
      { "point": 6545, "usage": "get", "miss": 2, "pmap": 8750218 }, 
      { "point": 6578, "usage": "put", "imap": 3360359 }, 
      { "point": 6596, "usage": "get", "imap": 3360359 }, 
      { "point": 6607, "usage": "get", "imap": 3360359 }, 
      { "point": 6635, "usage": "put", "imap": 5389859 }, 
      { "point": 6652, "usage": "get", "imap": 5389859 }, 
      { "point": 6663, "usage": "get", "imap": 5389859 }, 
      { "point": 6677, "usage": "put", "imap": 5389859 }, 
      { "point": 6695, "usage": "get", "imap": 5389859 }, 
      { "point": 6706, "usage": "get", "miss": 2, "pmap": 5389858 }, 
      { "point": 6919, "usage": "get", "imap": 819179 }, 
      { "point": 6966, "usage": "get", "miss": 2, "pmap": 819178 }, 
      { "point": 6992, "usage": "get", "imap": 819179 }, 
      { "point": 7008, "usage": "get", "imap": 819179 }, 
      { "point": 7019, "usage": "get", "imap": 819179 }, 
      { "point": 7349, "usage": "get", "imap": 1521918 }, 
      { "point": 7368, "usage": "get", "imap": 760959 }, 
      { "point": 7379, "usage": "get", "miss": 2, "pmap": 760958 }, 
      { "point": 7406, "usage": "get", "imap": 760959 }, 
      { "point": 7417, "usage": "get", "imap": 760959 }, 
      { "point": 7649, "usage": "get", "imap": 1905679 }, 
      { "point": 7660, "usage": "get", "miss": 2, "pmap": 1905678 }, 
      { "point": 7692, "usage": "get", "imap": 1905679 }, 
      { "point": 7979, "usage": "get", "imap": 1904039 }, 
      { "point": 7993, "usage": "get", "imap": 1904039 }, 
      { "point": 8030, "usage": "get", "imap": 3808078 }, 
      { "point": 8052, "usage": "put", "imap": 1904039 }, 
      { "point": 8073, "usage": "put", "imap": 1904039 }, 
      { "point": 8083, "usage": "get", "imap": 1904039 }, 
      { "point": 8104, "usage": "get", "miss": 2, "pmap": 1904038 }, 
      { "point": 8126, "usage": "get", "imap": 1904039 }, 
      { "point": 8728, "usage": "put", "miss": 3, "emap": 2457 }, 
      { "point": 8771, "usage": "put", "miss": 4, "emap": 2456 }, 
      { "point": 9367, "usage": "put", "imap": 819 }, 
      { "point": 9457, "usage": "put", "imap": 819179 }, 
      { "point": 9470, "usage": "get", "imap": 819179 }, 
      { "point": 9558, "usage": "put", "imap": 760959 }, 
      { "point": 9571, "usage": "get", "imap": 760959 }, 
      { "point": 9670, "usage": "get", "imap": 8750219 }, 
      { "point": 9704, "usage": "get", "imap": 8294299 }, 
      { "point": 9800, "usage": "put", "imap": 1905679 }, 
      { "point": 9813, "usage": "get", "imap": 1905679 }, 
      { "point": 9906, "usage": "put", "imap": 1212779 }, 
      { "point": 9919, "usage": "get", "imap": 1212779 }, 
      { "point": 10102, "usage": "get", "imap": 5389859 }, 
      { "point": 10156, "usage": "get", "imap": 1907319 }, 
      { "point": 10171, "usage": "put", "imap": 1907319 }, 
      { "point": 10186, "usage": "get", "imap": 1907319 }, 
      { "point": 10204, "usage": "get", "imap": 1907319 }, 
      { "point": 10231, "usage": "put", "imap": 1213599 }, 
      { "point": 10276, "usage": "put", "imap": 693719 }, 
      { "point": 10349, "usage": "get", "imap": 5389859 }, 
      { "point": 10354, "usage": "get", "miss": 2911000, "pmap": 2478860 }, 
      { "point": 10636, "usage": "get", "imap": 1904039 }, 
      { "point": 10661, "usage": "put", "imap": 1212779 }, 
      { "point": 10685, "usage": "get", "miss": 2, "pmap": 1212778 }, 
      { "point": 10715, "usage": "get", "imap": 1212779 }, 
      { "point": 10731, "usage": "get", "imap": 1212779 }, 
      { "point": 10772, "usage": "put", "imap": 691259 }, 
      { "point": 10787, "usage": "get", "miss": 2, "pmap": 691258 }, 
      { "point": 10798, "usage": "get", "imap": 691259 }, 
      { "point": 11321, "usage": "put", "miss": 3, "emap": 817 }, 
      { "point": 11350, "usage": "put", "miss": 3, "emap": 817 }, 
      { "point": 11365, "usage": "put", "miss": 3, "emap": 817 }, 
      { "point": 11434, "usage": "get", "imap": 1639998 }, 
      { "point": 11453, "usage": "get", "imap": 819999 }, 
      { "point": 11477, "usage": "get", "imap": 819 }, 
      { "point": 11487, "usage": "get", "miss": 2, "pmap": 818 }, 
      { "point": 11513, "usage": "get", "imap": 819179 }, 
      { "point": 11537, "usage": "put", "imap": 411639 }, 
      { "point": 11547, "usage": "get", "imap": 411639 }, 
      { "point": 11571, "usage": "get", "imap": 411639 }, 
      { "point": 11581, "usage": "get", "miss": 2, "pmap": 411638 }, 
      { "point": 11621, "usage": "put", "imap": 407539 }, 
      { "point": 11632, "usage": "get", "imap": 407539 }, 
      { "point": 11666, "usage": "get", "imap": 407539 }, 
      { "point": 11676, "usage": "get", "miss": 2, "pmap": 407538 }, 
      { "point": 12019, "usage": "put", "miss": 3, "emap": 1637 }, 
      { "point": 12048, "usage": "put", "miss": 2, "emap": 1638 }, 
      { "point": 12144, "usage": "get", "imap": 1516999 }, 
      { "point": 12168, "usage": "get", "imap": 758499 }, 
      { "point": 12178, "usage": "get", "miss": 2, "pmap": 758498 }, 
      { "point": 12212, "usage": "get", "imap": 758499 }, 
      { "point": 12224, "usage": "put", "imap": 758499 }, 
      { "point": 12250, "usage": "get", "imap": 758499 }, 
      { "point": 12260, "usage": "get", "miss": 2, "pmap": 758498 }, 
      { "point": 12288, "usage": "put", "imap": 760139 }, 
      { "point": 12316, "usage": "get", "imap": 760139 }, 
      { "point": 12326, "usage": "get", "miss": 2, "pmap": 760138 }, 
      { "point": 12751, "usage": "put", "miss": 3, "emap": 817 }, 
      { "point": 12780, "usage": "put", "miss": 3, "emap": 817 }, 
      { "point": 12795, "usage": "put", "miss": 3, "emap": 817 }, 
      { "point": 12892, "usage": "get", "imap": 191879 }, 
      { "point": 12902, "usage": "get", "miss": 2, "pmap": 191878 }, 
      { "point": 12942, "usage": "get", "imap": 191879 }, 
      { "point": 12974, "usage": "put", "imap": 95939 }, 
      { "point": 13015, "usage": "put", "imap": 95939 }, 
      { "point": 13049, "usage": "put", "imap": 191879 }, 
      { "point": 13059, "usage": "get", "imap": 191879 }, 
      { "point": 13073, "usage": "put", "imap": 191879 }, 
      { "point": 13132, "usage": "get", "imap": 1535038 }, 
      { "point": 13152, "usage": "get", "imap": 767519 }, 
      { "point": 13166, "usage": "put", "imap": 28699 }, 
      { "point": 13186, "usage": "get", "imap": 1535039 }, 
      { "point": 13199, "usage": "get", "imap": 767519 }, 
      { "point": 13223, "usage": "get", "imap": 191879 }, 
      { "point": 13233, "usage": "get", "miss": 2, "pmap": 191878 }, 
      { "point": 13522, "usage": "put", "miss": 4, "emap": 1636 }, 
      { "point": 13551, "usage": "put", "miss": 4, "emap": 1636 }, 
      { "point": 13568, "usage": "put", "miss": 3, "emap": 1637 }, 
      { "point": 13667, "usage": "get", "imap": 955299 }, 
      { "point": 13698, "usage": "put", "imap": 191879 }, 
      { "point": 13710, "usage": "get", "miss": 2, "pmap": 191878 }, 
      { "point": 13721, "usage": "get", "imap": 191879 }, 
      { "point": 13748, "usage": "put", "imap": 763419 }, 
      { "point": 13760, "usage": "get", "miss": 2, "pmap": 763418 }, 
      { "point": 13771, "usage": "get", "imap": 763419 }, 
      { "point": 13794, "usage": "get", "imap": 1908959 }, 
      { "point": 13828, "usage": "get", "imap": 1661319 }, 
      { "point": 13831, "usage": "get", "imap": 1661319 }, 
      { "point": 13887, "usage": "get", "imap": 1471079 }, 
      { "point": 13917, "usage": "get", "imap": 763419 }, 
      { "point": 13933, "usage": "put", "imap": 763419 }, 
      { "point": 13943, "usage": "get", "imap": 763419 }, 
      { "point": 13946, "usage": "get", "imap": 763419 }, 
      { "point": 13961, "usage": "put", "imap": 763419 }, 
      { "point": 13971, "usage": "get", "imap": 763419 }, 
      { "point": 13974, "usage": "get", "imap": 763419 }, 
      { "point": 13997, "usage": "get", "imap": 763419 }, 
      { "point": 14000, "usage": "put", "imap": 763419 }, 
      { "point": 14035, "usage": "get", "imap": 763419 }, 
      { "point": 14045, "usage": "get", "miss": 2, "pmap": 763418 }, 
      { "point": 14088, "usage": "get", "imap": 190239 }, 
      { "point": 14102, "usage": "put", "imap": 190239 }, 
      { "point": 14112, "usage": "get", "imap": 190239 }, 
      { "point": 14115, "usage": "get", "imap": 190239 }, 
      { "point": 14138, "usage": "get", "imap": 190239 }, 
      { "point": 14148, "usage": "get", "miss": 2, "pmap": 190238 }, 
      { "point": 14179, "usage": "get", "imap": 955299 }, 
      { "point": 14189, "usage": "get", "miss": 2, "pmap": 955298 }, 
      { "point": 14863, "usage": "put", "miss": 6, "emap": 6554 }, 
      { "point": 14882, "usage": "put", "miss": 6, "emap": 6554 }, 
      { "point": 14897, "usage": "put", "miss": 6, "emap": 6554 }, 
      { "point": 14916, "usage": "put", "miss": 6, "emap": 6554 }, 
      { "point": 14930, "usage": "put", "miss": 5, "emap": 6555 }, 
      { "point": 15145, "usage": "put", "imap": 1646559 }, 
      { "point": 15237, "usage": "get", "imap": 858539 }, 
      { "point": 15274, "usage": "put", "imap": 829019 }, 
      { "point": 15727, "usage": "get", "imap": 819 }, 
      { "point": -1 } ]
  },
  { "filename": "", "caches": [] }
],
"config": {
  "tmp": "/tmp/alexandrebergel/J2S/richards.js",
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
  "filename": "richards.js",
  "driver-name": "j2s-optim-driver",
  "worker": true,
  "worker-slave": false,
  "module-main": true,
  "module-name": "richards",
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
  "date": "Wed Dec 19 11:52:30 2018"
  }
}
'
]

{ #category : #'as yet unclassified' }
HOPBasicTest >> exampleRichardsJS [
^ '// Copyright 2006-2008 the V8 project authors. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//     * Neither the name of Google Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


// This is a JavaScript implementation of the Richards
// benchmark from:
//
//    http://www.cl.cam.ac.uk/~mr10/Bench.html
//
// The benchmark was originally implemented in BCPL by
// Martin Richards.
"use strict";

/**
* The Richards benchmark simulates the task dispatcher of an
* operating system.
**/
function runRichards() {
 var scheduler = new Scheduler();
 scheduler.addIdleTask(ID_IDLE, 0, null, COUNT);

 var queue = new Packet(null, ID_WORKER, KIND_WORK);
 queue = new Packet(queue,  ID_WORKER, KIND_WORK);
 scheduler.addWorkerTask(ID_WORKER, 1000, queue);

 queue = new Packet(null, ID_DEVICE_A, KIND_DEVICE);
 queue = new Packet(queue,  ID_DEVICE_A, KIND_DEVICE);
 queue = new Packet(queue,  ID_DEVICE_A, KIND_DEVICE);
 scheduler.addHandlerTask(ID_HANDLER_A, 2000, queue);

 queue = new Packet(null, ID_DEVICE_B, KIND_DEVICE);
 queue = new Packet(queue,  ID_DEVICE_B, KIND_DEVICE);
 queue = new Packet(queue,  ID_DEVICE_B, KIND_DEVICE);
 scheduler.addHandlerTask(ID_HANDLER_B, 3000, queue);

 scheduler.addDeviceTask(ID_DEVICE_A, 4000, null);

 scheduler.addDeviceTask(ID_DEVICE_B, 5000, null);

 scheduler.schedule();

 if (scheduler.queueCount != EXPECTED_QUEUE_COUNT ||
     scheduler.holdCount != EXPECTED_HOLD_COUNT) {
   var msg =
       "Error during execution: queueCount = " + scheduler.queueCount +
       ", holdCount = " + scheduler.holdCount + ".";
   throw new Error(msg);
 }
}

var COUNT = 1000;

/**
* These two constants specify how many times a packet is queued and
* how many times a task is put on hold in a correct run of richards.
* They don''t have any meaning a such but are characteristic of a
* correct run so if the actual queue or hold count is different from
* the expected there must be a bug in the implementation.
**/
var EXPECTED_QUEUE_COUNT = 2322;
var EXPECTED_HOLD_COUNT = 928;


/**
* A scheduler can be used to schedule a set of tasks based on their relative
* priorities.  Scheduling is done by maintaining a list of task control blocks
* which holds tasks and the data queue they are processing.
* @constructor
*/
function Scheduler() {
 this.queueCount = 0;
 this.holdCount = 0;
 this.blocks = new Array(NUMBER_OF_IDS);
 this.list = null;
 this.currentTcb = null;
 this.currentId = null;
}

var ID_IDLE       = 0;
var ID_WORKER     = 1;
var ID_HANDLER_A  = 2;
var ID_HANDLER_B  = 3;
var ID_DEVICE_A   = 4;
var ID_DEVICE_B   = 5;
var NUMBER_OF_IDS = 6;

var KIND_DEVICE   = 0;
var KIND_WORK     = 1;

/**
* Add an idle task to this scheduler.
* @param {int} id the identity of the task
* @param {int} priority the task''s priority
* @param {Packet} queue the queue of work to be processed by the task
* @param {int} count the number of times to schedule the task
*/
Scheduler.prototype.addIdleTask = function (id, priority, queue, count) {
 this.addRunningTask(id, priority, queue, new IdleTask(this, 1, count));
};

/**
* Add a work task to this scheduler.
* @param {int} id the identity of the task
* @param {int} priority the task''s priority
* @param {Packet} queue the queue of work to be processed by the task
*/
Scheduler.prototype.addWorkerTask = function (id, priority, queue) {
 this.addTask(id, priority, queue, new WorkerTask(this, ID_HANDLER_A, 0));
};

/**
* Add a handler task to this scheduler.
* @param {int} id the identity of the task
* @param {int} priority the task''s priority
* @param {Packet} queue the queue of work to be processed by the task
*/
Scheduler.prototype.addHandlerTask = function (id, priority, queue) {
 this.addTask(id, priority, queue, new HandlerTask(this));
};

/**
* Add a handler task to this scheduler.
* @param {int} id the identity of the task
* @param {int} priority the task''s priority
* @param {Packet} queue the queue of work to be processed by the task
*/
Scheduler.prototype.addDeviceTask = function (id, priority, queue) {
 this.addTask(id, priority, queue, new DeviceTask(this))
};

/**
* Add the specified task and mark it as running.
* @param {int} id the identity of the task
* @param {int} priority the task''s priority
* @param {Packet} queue the queue of work to be processed by the task
* @param {Task} task the task to add
*/
Scheduler.prototype.addRunningTask = function (id, priority, queue, task) {
 this.addTask(id, priority, queue, task);
 this.currentTcb.setRunning();
};

/**
* Add the specified task to this scheduler.
* @param {int} id the identity of the task
* @param {int} priority the task''s priority
* @param {Packet} queue the queue of work to be processed by the task
* @param {Task} task the task to add
*/
Scheduler.prototype.addTask = function (id, priority, queue, task) {
 this.currentTcb = new TaskControlBlock(this.list, id, priority, queue, task);
 this.list = this.currentTcb;
 this.blocks[id] = this.currentTcb;
};

/**
* Execute the tasks managed by this scheduler.
*/
Scheduler.prototype.schedule = function () {
 this.currentTcb = this.list;
 while (this.currentTcb != null) {
   if (this.currentTcb.isHeldOrSuspended()) {
     this.currentTcb = this.currentTcb.link;
   } else {
     this.currentId = this.currentTcb.id;
     this.currentTcb = this.currentTcb.run();
   }
 }
};

/**
* Release a task that is currently blocked and return the next block to run.
* @param {int} id the id of the task to suspend
*/
Scheduler.prototype.release = function (id) {
 var tcb = this.blocks[id];
 if (tcb == null) return tcb;
 tcb.markAsNotHeld();
 if (tcb.priority > this.currentTcb.priority) {
   return tcb;
 } else {
   return this.currentTcb;
 }
};

/**
* Block the currently executing task and return the next task control block
* to run.  The blocked task will not be made runnable until it is explicitly
* released, even if new work is added to it.
*/
Scheduler.prototype.holdCurrent = function () {
 this.holdCount++;
 this.currentTcb.markAsHeld();
 return this.currentTcb.link;
};

/**
* Suspend the currently executing task and return the next task control block
* to run.  If new work is added to the suspended task it will be made runnable.
*/
Scheduler.prototype.suspendCurrent = function () {
 this.currentTcb.markAsSuspended();
 return this.currentTcb;
};

/**
* Add the specified packet to the end of the worklist used by the task
* associated with the packet and make the task runnable if it is currently
* suspended.
* @param {Packet} packet the packet to add
*/
Scheduler.prototype.queue = function (packet) {
 var t = this.blocks[packet.id];
 if (t == null) return t;
 this.queueCount++;
 packet.link = null;
 packet.id = this.currentId;
 return t.checkPriorityAdd(this.currentTcb, packet);
};

/**
* A task control block manages a task and the queue of work packages associated
* with it.
* @param {TaskControlBlock} link the preceding block in the linked block list
* @param {int} id the id of this block
* @param {int} priority the priority of this block
* @param {Packet} queue the queue of packages to be processed by the task
* @param {Task} task the task
* @constructor
*/
function TaskControlBlock(link, id, priority, queue, task) {
 this.link = link;
 this.id = id;
 this.priority = priority;
 this.queue = queue;
 this.task = task;
 if (queue == null) {
   this.state = STATE_SUSPENDED;
 } else {
   this.state = STATE_SUSPENDED_RUNNABLE;
 }
}

/**
* The task is running and is currently scheduled.
*/
var STATE_RUNNING = 0;

/**
* The task has packets left to process.
*/
var STATE_RUNNABLE = 1;

/**
* The task is not currently running.  The task is not blocked as such and may
* be started by the scheduler.
*/
var STATE_SUSPENDED = 2;

/**
* The task is blocked and cannot be run until it is explicitly released.
*/
var STATE_HELD = 4;

var STATE_SUSPENDED_RUNNABLE = STATE_SUSPENDED | STATE_RUNNABLE;
var STATE_NOT_HELD = ~STATE_HELD;

TaskControlBlock.prototype.setRunning = function () {
 this.state = STATE_RUNNING;
};

TaskControlBlock.prototype.markAsNotHeld = function () {
 this.state = this.state & STATE_NOT_HELD;
};

TaskControlBlock.prototype.markAsHeld = function () {
 this.state = this.state | STATE_HELD;
};

TaskControlBlock.prototype.isHeldOrSuspended = function () {
 return (this.state & STATE_HELD) != 0 || (this.state == STATE_SUSPENDED);
};

TaskControlBlock.prototype.markAsSuspended = function () {
 this.state = this.state | STATE_SUSPENDED;
};

TaskControlBlock.prototype.markAsRunnable = function () {
 this.state = this.state | STATE_RUNNABLE;
};

/**
* Runs this task, if it is ready to be run, and returns the next task to run.
*/
TaskControlBlock.prototype.run = function () {
 var packet;
 if (this.state == STATE_SUSPENDED_RUNNABLE) {
   packet = this.queue;
   this.queue = packet.link;
   if (this.queue == null) {
     this.state = STATE_RUNNING;
   } else {
     this.state = STATE_RUNNABLE;
   }
 } else {
   packet = null;
 }
 return this.task.run(packet);
};

/**
* Adds a packet to the worklist of this block''s task, marks this as runnable if
* necessary, and returns the next runnable object to run (the one
* with the highest priority).
*/
TaskControlBlock.prototype.checkPriorityAdd = function (task, packet) {
 if (this.queue == null) {
   this.queue = packet;
   this.markAsRunnable();
   if (this.priority > task.priority) return this;
 } else {
   this.queue = packet.addTo(this.queue);
 }
 return task;
};

TaskControlBlock.prototype.toString = function () {
 return "tcb { " + this.task + "@" + this.state + " }";
};

/**
* An idle task doesn''t do any work itself but cycles control between the two
* device tasks.
* @param {Scheduler} scheduler the scheduler that manages this task
* @param {int} v1 a seed value that controls how the device tasks are scheduled
* @param {int} count the number of times this task should be scheduled
* @constructor
*/
function IdleTask(scheduler, v1, count) {
 this.scheduler = scheduler;
 this.v1 = v1;
 this.count = count;
}

IdleTask.prototype.run = function (packet) {
 this.count--;
 if (this.count == 0) return this.scheduler.holdCurrent();
 if ((this.v1 & 1) == 0) {
   this.v1 = this.v1 >> 1;
   return this.scheduler.release(ID_DEVICE_A);
 } else {
   this.v1 = (this.v1 >> 1) ^ 0xD008;
   return this.scheduler.release(ID_DEVICE_B);
 }
};

IdleTask.prototype.toString = function () {
 return "IdleTask"
};

/**
* A task that suspends itself after each time it has been run to simulate
* waiting for data from an external device.
* @param {Scheduler} scheduler the scheduler that manages this task
* @constructor
*/
function DeviceTask(scheduler) {
 this.scheduler = scheduler;
 this.v1 = null;
}

DeviceTask.prototype.run = function (packet) {
 if (packet == null) {
   if (this.v1 == null) return this.scheduler.suspendCurrent();
   var v = this.v1;
   this.v1 = null;
   return this.scheduler.queue(v);
 } else {
   this.v1 = packet;
   return this.scheduler.holdCurrent();
 }
};

DeviceTask.prototype.toString = function () {
 return "DeviceTask";
};

/**
* A task that manipulates work packets.
* @param {Scheduler} scheduler the scheduler that manages this task
* @param {int} v1 a seed used to specify how work packets are manipulated
* @param {int} v2 another seed used to specify how work packets are manipulated
* @constructor
*/
function WorkerTask(scheduler, v1, v2) {
 this.scheduler = scheduler;
 this.v1 = v1;
 this.v2 = v2;
}

WorkerTask.prototype.run = function (packet) {
 if (packet == null) {
   return this.scheduler.suspendCurrent();
 } else {
   if (this.v1 == ID_HANDLER_A) {
     this.v1 = ID_HANDLER_B;
   } else {
     this.v1 = ID_HANDLER_A;
   }
   packet.id = this.v1;
   packet.a1 = 0;
   for (var i = 0; i < DATA_SIZE; i++) {
     this.v2++;
     if (this.v2 > 26) this.v2 = 1;
     packet.a2[i] = this.v2;
   }
   return this.scheduler.queue(packet);
 }
};

WorkerTask.prototype.toString = function () {
 return "WorkerTask";
};

/**
* A task that manipulates work packets and then suspends itself.
* @param {Scheduler} scheduler the scheduler that manages this task
* @constructor
*/
function HandlerTask(scheduler) {
 this.scheduler = scheduler;
 this.v1 = null;
 this.v2 = null;
}

HandlerTask.prototype.run = function (packet) {
 if (packet != null) {
   if (packet.kind == KIND_WORK) {
     this.v1 = packet.addTo(this.v1);
   } else {
     this.v2 = packet.addTo(this.v2);
   }
 }
 if (this.v1 != null) {
   var count = this.v1.a1;
   var v;
   if (count < DATA_SIZE) {
     if (this.v2 != null) {
       v = this.v2;
       this.v2 = this.v2.link;
       v.a1 = this.v1.a2[count];
       this.v1.a1 = count + 1;
       return this.scheduler.queue(v);
     }
   } else {
     v = this.v1;
     this.v1 = this.v1.link;
     return this.scheduler.queue(v);
   }
 }
 return this.scheduler.suspendCurrent();
};

HandlerTask.prototype.toString = function () {
 return "HandlerTask";
};

/* --- *
* P a c k e t
* --- */

var DATA_SIZE = 4;

/**
* A simple package of data that is manipulated by the tasks.  The exact layout
* of the payload data carried by a packet is not importaint, and neither is the
* nature of the work performed on packets by the tasks.
*
* Besides carrying data, packets form linked lists and are hence used both as
* data and worklists.
* @param {Packet} link the tail of the linked list of packets
* @param {int} id an ID for this packet
* @param {int} kind the type of this packet
* @constructor
*/
function Packet(link, id, kind) {
 this.link = link;
 this.id = id;
 this.kind = kind;
 this.a1 = 0;
 this.a2 = new Array(DATA_SIZE);
}

/**
* Add this packet to the end of a worklist, and return the worklist.
* @param {Packet} queue the worklist to add this packet to
*/
Packet.prototype.addTo = function (queue) {
 this.link = null;
 if (queue == null) return this;
 var peek, next = queue;
 while ((peek = next.link) != null)
   next = peek;
 next.link = this;
 return queue;
};

Packet.prototype.toString = function () {
 return "Packet";
};

var go;

function Benchmark( name, opt1, opt2, it, go ) {
  return { go: go, iteration: it };
}

function BenchmarkSuite( name, val, benchs ) {
  go = function() {
     var num = benchs[ 0 ].iteration;
     var n = Math.round( num / 10 ), i = 1;
     console.log( name );
     while( num-- > 0 ) {
	 if( num % n == 0 ) { console.log( i++ ); }
	 benchs[ 0 ].go()
     };
  }
}

var Richards = BenchmarkSuite(''Richards'', [35302], [
 Benchmark("Richards", true, false, 820 * 1, runRichards)
]);


go();'
]

{ #category : #tests }
HOPBasicTest >> testBasic [
	| window |
	[ window := HOPVisualizer new
		openOnJSSource: HOPBasicTest new exampleJS
		cacheSource: HOPBasicTest new exampleCacheAndLocationJSON. ]
		ensure: [ window ifNotNil: [ window delete ] ]
]

{ #category : #tests }
HOPBasicTest >> testBasic2 [
	| h |
	h := HOPVisualizer new.
	h setJSSource: HOPBasicTest new exampleJS cacheSource: HOPBasicTest new exampleCacheAndLocationJSON.
	
	self assert: h rubricModel numberOfSegments equals: 29.
]

{ #category : #tests }
HOPBasicTest >> testRunningExamples [
	| w |
	(HOPVisualizer selectors select: [ :k | k beginsWith: 'example' ])
		do: [ :k | 
			[ w := HOPVisualizer new perform: k ]
				ensure: [ w ifNotNil: [ w delete ] ] ]
]
