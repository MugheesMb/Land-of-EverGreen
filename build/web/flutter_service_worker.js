'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "1711d0764e45fe16db5a08c1b106f143",
"assets/AssetManifest.bin.json": "1d51ba533614a6ed0ebb5fcd540e38d5",
"assets/AssetManifest.json": "ae2f747866f1186ff62521b85768b138",
"assets/assets/audio/coin.wav": "44c9e34c2eabb4f73e5094e145a01104",
"assets/assets/audio/eco.wav": "2619a1755a77d1a6389a21fa7f3d0e18",
"assets/assets/audio/enemy.wav": "1c8f54ea8fba8c5db6b3d5c1409f0d91",
"assets/assets/audio/jump.wav": "7c567c2be528bc465f51caad6bc11090",
"assets/assets/audio/plastic.wav": "0b6588fa4e1a85f8db8352d1521db77b",
"assets/assets/font/rexlia.ttf": "4a46e8256b9b614a72e187eec6e9c7d3",
"assets/assets/images/1.png": "c4d1d782cfc3451da8d18cd9a7f0a2eb",
"assets/assets/images/2.jpeg": "e3695d8f4b3a79b6a41d2610b6782f05",
"assets/assets/images/2.tsx": "0d852392d1a8b0a8729ed3b8c37f9baf",
"assets/assets/images/3.png": "8b7fb9ff1c27860120e4b019f370ad07",
"assets/assets/images/3.tsx": "4a30479a18f312e117bc4435adaa15b3",
"assets/assets/images/4.png": "99bb0e4e0536bb91f9703adff269bf44",
"assets/assets/images/4.tsx": "370696a28281eb54ab8ba0a16441b27a",
"assets/assets/images/5.jpeg": "c76aac9b931d9d0edb2db8e852f79184",
"assets/assets/images/6.png": "080f9c2b0762e6777cadafa4e54783e7",
"assets/assets/images/6.tsx": "2381a1976e79343ad48eb33f2813ec7c",
"assets/assets/images/7.png": "8a53bfa35be60612f4ec8c8500dadd62",
"assets/assets/images/7.tsx": "463178c946e70532171725ec7a15ea8a",
"assets/assets/images/a.png": "8b196143913c6ebc3c54f7cadc252efe",
"assets/assets/images/b.png": "4c14732c1b0c83e200be28e72cdcf0db",
"assets/assets/images/Bat.png": "5d82e0dac55e5858fa64982455b300c7",
"assets/assets/images/bg3%2520(1).png": "c515aa18d108c209421720561f7b7658",
"assets/assets/images/bg3.png": "f675c67f6ed468eb35edb4fa96d333ea",
"assets/assets/images/bin.png": "b9e6157eab6048fc840b24ede2ba17ff",
"assets/assets/images/bird-feeder.png": "2582826af09f36f67ece6f75e5e1bfb7",
"assets/assets/images/bot.png": "d4bac21dd69055efecba617f32b8fe63",
"assets/assets/images/bricks.png": "8c71122e7fb848ccd106ba0617377798",
"assets/assets/images/c.png": "fc8e4e7a16fccc001b4ca30558e95012",
"assets/assets/images/c1.png": "64f25567db58a7dadcf1c5716830687e",
"assets/assets/images/c1.tsx": "8e198e6f20133e1b7ecf66d666b02c82",
"assets/assets/images/c2.png": "9fa9e3c9f2abaa92a0e2f07ec4c4ff4c",
"assets/assets/images/c3.png": "d77a9204bf4bd680269bae13cbd94a14",
"assets/assets/images/c3.tsx": "3a1b70ab5e0211d816012fc4602baae5",
"assets/assets/images/c4.png": "2c4b25ebd1dda1e0c5cda3a3e16fa59b",
"assets/assets/images/c4.tsx": "1f87c7920fadb7512d5ca4ed3d7020eb",
"assets/assets/images/cans.png": "94827636af8f2aa068b4954dd4b3ae7d",
"assets/assets/images/cave.png": "d74a61d5e191c6f90d2fa811a650a99e",
"assets/assets/images/cave.tsx": "f8035bbc95b47d61a70915d28fc392d4",
"assets/assets/images/cave2.jpeg": "8da89f53483314226f857a414fd0a178",
"assets/assets/images/cave2.tsx": "5e21de98e36f46e5a79c2907bf1f1061",
"assets/assets/images/collection.png": "273ee26847c0129f7293e4b41c81ca63",
"assets/assets/images/cup.png": "8e2ee5f21bb268774cf53f6bf2bb203e",
"assets/assets/images/d.png": "07b3b85e4f8c30db4fb0e600739783e4",
"assets/assets/images/dus.png": "4238d3b868e98ddd029a654b45ee9461",
"assets/assets/images/dus.tsx": "8d0a73e1c5ba0c34b22657a807cd8480",
"assets/assets/images/e.png": "057971498a26c988035c7889b804a6de",
"assets/assets/images/eco.gif": "af22e49d7190fe43275f4a8aa3bb4fc8",
"assets/assets/images/eco.png": "30ff5351cc391c6b3b9461cc3695e7eb",
"assets/assets/images/en.png": "9a965aabe745381e49c6855a0e65b8e7",
"assets/assets/images/enee.png": "d45916f82919bb6e3fafce8d536fc624",
"assets/assets/images/enem1.png": "a6399d9d522438d80fecadcf0cd0e6f5",
"assets/assets/images/enemy.png": "5b52c86a40206661acb77ab777deea81",
"assets/assets/images/exit.png": "2017526cb30b286ea6a96d60be8c5c5a",
"assets/assets/images/f.png": "078d13439cf16fb7f486c5560eca4e88",
"assets/assets/images/Flying%2520(46x30).png": "7986dfad436b4607994d3fe1ecced6ce",
"assets/assets/images/fs.png": "080c672b5dfad523301d305429673f07",
"assets/assets/images/g.png": "1c78ad06ab8301c1a5f5c11d7f23c002",
"assets/assets/images/go.png": "7b336052fca4250a234ac6638ad63b76",
"assets/assets/images/head.png": "da94b87797288f8fca6090848c463440",
"assets/assets/images/her.png": "8301960025306c5eda1a6029d10b6b8e",
"assets/assets/images/her2.png": "1e41e1006f77b62eef2d55c276041472",
"assets/assets/images/her3.png": "335e1e8a6e938a16c6680b4041874564",
"assets/assets/images/her4.png": "af4f5a77fe12c3483317eae067c2d10d",
"assets/assets/images/Joystick.png": "3f238321a65fe05dac6251ff44098a60",
"assets/assets/images/lamps.png": "3d7e8605ef02b4efbbc67034ec6917ee",
"assets/assets/images/last.png": "c787c752f86fbf88793e0067e913c242",
"assets/assets/images/learn.png": "23749b68b1aeb26ee9f0e42abc358cd0",
"assets/assets/images/lock.png": "5e39fe8f2fb4acdcbb74bbe74b0b4f62",
"assets/assets/images/m1.gif": "9bc702b1214178361e33929f6a36f72c",
"assets/assets/images/m2.gif": "4add378b9482e04022384077f92aba6d",
"assets/assets/images/m22.gif": "ff70661ed9b737bda00ea0006af79fe0",
"assets/assets/images/m3.gif": "a3843d3311996b84c364da2109c6316a",
"assets/assets/images/men.png": "32aae051b9c3bbba2ad83afbf14e8394",
"assets/assets/images/men2.png": "1c83736a9ee48e2dc64b4a84fcd8a384",
"assets/assets/images/MM.gif": "1119be84bb6db5879c3af16e4e58ee20",
"assets/assets/images/new.png": "ea01f2fc552cf630f465759760b4ffc2",
"assets/assets/images/next.png": "48a8aa2214058beeb743db78f40ac6cf",
"assets/assets/images/planters.png": "e093ecd9e5afe61f21cd59eee827150b",
"assets/assets/images/plat.png": "4df99ec94c040db0a0cb14cfad9cf0f4",
"assets/assets/images/play-btn.png": "ae8308f4f9c1a5b53b4d6ab3c63278a3",
"assets/assets/images/play.png": "f3e0f7464214964e8a34a6f00b94e65f",
"assets/assets/images/plt.png": "05ba3f276f7db30611e0ab57ab09d8ed",
"assets/assets/images/recycle.png": "b4c68390bc8eaf6da03bf31ccfd982b7",
"assets/assets/images/restart-btn.png": "386945adfb8b17a0d43aaf454ff0c644",
"assets/assets/images/resume-btn.png": "35b620c6fad7efca7ede108d3eb89141",
"assets/assets/images/retry.png": "8bb08039257ad2ca69353c4656a8b299",
"assets/assets/images/road.tiff": "97f968078dd2b7cc838c6bf4fb05e8e5",
"assets/assets/images/road1.tsx": "96d8c776c933e956445941643f868eeb",
"assets/assets/images/rt.tsx": "22f327a192ada668143e1466e75e0597",
"assets/assets/images/settings.png": "dbca08aaa37e2febc34cb4eb47532212",
"assets/assets/images/shop.png": "a4ecb56e91328076644336382bccf3e7",
"assets/assets/images/skip.png": "2e0d89ee381e0c304c52bf40ffe40256",
"assets/assets/images/sky.jpeg": "51bb98489bf90fe277971112bc0abffd",
"assets/assets/images/slash.png": "9dd9b31b31619b8020d0f3d48f6d5ae2",
"assets/assets/images/SmallHandle.png": "aa31a0ac9e4b513711b3f2c65d4935fb",
"assets/assets/images/SmallHandleFilledGrey.png": "5278579d4a8bcca137e61c16bd451744",
"assets/assets/images/star.png": "c4176faf2269e43c722b0e5a39c9074a",
"assets/assets/images/stars1.png": "c25761cd6cade2f6dde20d36fde8218c",
"assets/assets/images/stars2.png": "b7bc0d6b8e94cdf1a05c1a9e0a28a229",
"assets/assets/images/stone.png": "42726941e836e479ea499f00de9dd097",
"assets/assets/images/stone.tsx": "dfa8631d74216b0c6e0bfb02f509ae36",
"assets/assets/images/storage.png": "857908d92c4937d5bab4c24143734711",
"assets/assets/images/t2.png": "6f652e4a2bf00c8acdfba016d35950f4",
"assets/assets/images/tiled.tsx": "a2f35a9515588fc6cf3bc32383923335",
"assets/assets/images/tre2.tsx": "d82489e6ee50f9f9bb532030b563faa6",
"assets/assets/images/try.png": "e66b0ced60c81793790de09b57cd22c2",
"assets/assets/images/Vine_1.png": "005e34a6b04f778311bc770e3bff6ade",
"assets/assets/images/wallet.png": "22a69f63479ec523d3b2222eab5ecbf5",
"assets/assets/tiles/aqua.tsx": "9bfc89fd7912f7bc7f34656024dd4775",
"assets/assets/tiles/bg3.tsx": "d857b7235e026085e4e359108bffd22c",
"assets/assets/tiles/last.tsx": "e14723b62638006c3190ae4ab48414cc",
"assets/assets/tiles/mb3.tmx": "9700e23826ec21881ae7ace7a3b14d25",
"assets/assets/tiles/moun.tsx": "eedd675574446f37f4ea900d5a09a721",
"assets/assets/tiles/sloth.tsx": "c41a60f880b6acb91fc8d98950d60078",
"assets/assets/tiles/star.tsx": "99ceeda04842af93c060f5e7d81da3e4",
"assets/assets/tiles/up.tmx": "ae01e365c2f170ffbd495a954beadb5d",
"assets/FontManifest.json": "411f1d3a3779921aeb4d14abeec173fe",
"assets/fonts/MaterialIcons-Regular.otf": "d9b89054f47852048bbbed6db21de09a",
"assets/NOTICES": "d61e73a489ddf59ac90c7c306470b006",
"assets/packages/add_to_google_wallet/assets/svg/buttons/ar_add_to_google_wallet_wallet-button.svg": "8ed2b5dc8ea42390bc1f22f9814954b0",
"assets/packages/add_to_google_wallet/assets/svg/buttons/az_add_to_google_wallet_wallet-button.svg": "1c545af772b2f9b1e50b23b63c9f98da",
"assets/packages/add_to_google_wallet/assets/svg/buttons/bg_add_to_google_wallet_wallet-button.svg": "fb36a9dd4688eabe5e9e50b029564227",
"assets/packages/add_to_google_wallet/assets/svg/buttons/br_add_to_google_wallet_wallet-button.svg": "d711b404a7d3b86f3cc5c8acedc50dbd",
"assets/packages/add_to_google_wallet/assets/svg/buttons/bs_add_to_google_wallet_wallet-button.svg": "6aa017fb69dfc3cf76058285e1d630d8",
"assets/packages/add_to_google_wallet/assets/svg/buttons/by_add_to_google_wallet_wallet-button.svg": "fc717a3f3da30fe862a310d643fe92ad",
"assets/packages/add_to_google_wallet/assets/svg/buttons/ca_add_to_google_wallet_wallet-button.svg": "0a4925620a47363661cb7a51b4ab5a58",
"assets/packages/add_to_google_wallet/assets/svg/buttons/cz_add_to_google_wallet_wallet-button.svg": "f3f2178af2bc4cdf103826cd98c9369b",
"assets/packages/add_to_google_wallet/assets/svg/buttons/de_add_to_google_wallet_wallet-button.svg": "bfb158c4b084482543e8ef901df02d21",
"assets/packages/add_to_google_wallet/assets/svg/buttons/dk_add_to_google_wallet_wallet-button.svg": "60d5092f469e20135016aaf3cc5d213b",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enAU_add_to_google_wallet_wallet-button.svg": "c283cb0dc517d3bc6de2590b3bac2fcf",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enCA_add_to_google_wallet_wallet-button.svg": "c283cb0dc517d3bc6de2590b3bac2fcf",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enGB_add_to_google_wallet_wallet-button.svg": "c283cb0dc517d3bc6de2590b3bac2fcf",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enIN_add_to_google_wallet_wallet-button.svg": "c283cb0dc517d3bc6de2590b3bac2fcf",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enSG_add_to_google_wallet_wallet-button.svg": "568708442552f3b3caaf6161f4868d72",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enUS_add_to_google_wallet_wallet-button.svg": "c283cb0dc517d3bc6de2590b3bac2fcf",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enZA_add_to_google_wallet_wallet-button.svg": "c283cb0dc517d3bc6de2590b3bac2fcf",
"assets/packages/add_to_google_wallet/assets/svg/buttons/es419_add_to_google_wallet_wallet-button.svg": "cb9db60b0742150ae3ab547e4f4ef0e6",
"assets/packages/add_to_google_wallet/assets/svg/buttons/esES_add_to_google_wallet_wallet-button.svg": "5946c137c2cb5015d3bb2d2b89bbfa2f",
"assets/packages/add_to_google_wallet/assets/svg/buttons/esUS_add_to_google_wallet_wallet-button.svg": "cb9db60b0742150ae3ab547e4f4ef0e6",
"assets/packages/add_to_google_wallet/assets/svg/buttons/et_add_to_google_wallet_wallet-button.svg": "c0b6fbcba5ea9e222d49da62d55c1f07",
"assets/packages/add_to_google_wallet/assets/svg/buttons/fl_add_to_google_wallet_wallet-button.svg": "d5141c1d2fa7c71f6d3f8024e60980a4",
"assets/packages/add_to_google_wallet/assets/svg/buttons/fp_add_to_google_wallet_wallet-button.svg": "23b16942ca07f225da0d4ff044825213",
"assets/packages/add_to_google_wallet/assets/svg/buttons/frCA_add_to_google_wallet_wallet-button.svg": "bc2f47f5f3b8f8f3253770fc89a540c7",
"assets/packages/add_to_google_wallet/assets/svg/buttons/frFR_add_to_google_wallet_wallet-button.svg": "bc2f47f5f3b8f8f3253770fc89a540c7",
"assets/packages/add_to_google_wallet/assets/svg/buttons/gr_add_to_google_wallet_wallet-button.svg": "64c855f01d129b8d71ceeea8ed2a3d71",
"assets/packages/add_to_google_wallet/assets/svg/buttons/he_add_to_google_wallet_wallet-button.svg": "a9a052a290a19f712a6685bbcd190ca0",
"assets/packages/add_to_google_wallet/assets/svg/buttons/hr_add_to_google_wallet_wallet-button.svg": "b6d10a9fbd63b345fc2825b1e4a3abf0",
"assets/packages/add_to_google_wallet/assets/svg/buttons/hu_add_to_google_wallet_wallet-button.svg": "e534db0e513768092bc4c2b6b4e3beea",
"assets/packages/add_to_google_wallet/assets/svg/buttons/hy_add_to_google_wallet_wallet-button.svg": "86474c2f3e14d467e45a8b9c2b81402b",
"assets/packages/add_to_google_wallet/assets/svg/buttons/id_add_to_google_wallet_wallet-button.svg": "7139c1614230fce1ea41c7f9cadda52f",
"assets/packages/add_to_google_wallet/assets/svg/buttons/is_add_to_google_wallet_wallet-button.svg": "cb03001a5ab3d58ebbfa3d6472aa4a23",
"assets/packages/add_to_google_wallet/assets/svg/buttons/it_add_to_google_wallet_wallet-button.svg": "fbdc320908b10990db14acc6f433ac7c",
"assets/packages/add_to_google_wallet/assets/svg/buttons/jp_add_to_google_wallet_wallet-button.svg": "d139a2176756c1b0ccf9c033450d4473",
"assets/packages/add_to_google_wallet/assets/svg/buttons/ka_add_to_google_wallet_wallet-button.svg": "be97561ee61811a8ac3dc8128b5301e8",
"assets/packages/add_to_google_wallet/assets/svg/buttons/kk_add_to_google_wallet_wallet-button.svg": "cecbc3f3d7973d388b088294b1ea265a",
"assets/packages/add_to_google_wallet/assets/svg/buttons/ky_add_to_google_wallet_wallet-button.svg": "157b7963b74a17c4bfd5de0db482b399",
"assets/packages/add_to_google_wallet/assets/svg/buttons/lt_add_to_google_wallet_wallet-button.svg": "cb8ba3e609a1b57f225f05eaddcb8e19",
"assets/packages/add_to_google_wallet/assets/svg/buttons/lv_add_to_google_wallet_wallet-button.svg": "943d879ec5f1533769d3bc60e849d213",
"assets/packages/add_to_google_wallet/assets/svg/buttons/mk_add_to_google_wallet_wallet-button.svg": "ec59cda1b4b0569349d5b04b5fecb177",
"assets/packages/add_to_google_wallet/assets/svg/buttons/my_add_to_google_wallet_wallet-button.svg": "04157e592054aabc39fd2215792baaea",
"assets/packages/add_to_google_wallet/assets/svg/buttons/nl_add_to_google_wallet_wallet-button.svg": "efaee620d9c06b1fd5181f2b2395a3d1",
"assets/packages/add_to_google_wallet/assets/svg/buttons/no_add_to_google_wallet_wallet-button.svg": "87eac0605cbb7056f2e32e270da14d07",
"assets/packages/add_to_google_wallet/assets/svg/buttons/pl_add_to_google_wallet_wallet-button.svg": "72e75b2a37a77648f882878b4512952b",
"assets/packages/add_to_google_wallet/assets/svg/buttons/pt_add_to_google_wallet_wallet-button.svg": "d711b404a7d3b86f3cc5c8acedc50dbd",
"assets/packages/add_to_google_wallet/assets/svg/buttons/ro_add_to_google_wallet_wallet-button.svg": "406323ed5b974f0f67fa516f7653bde0",
"assets/packages/add_to_google_wallet/assets/svg/buttons/ru_add_to_google_wallet_wallet-button.svg": "fc717a3f3da30fe862a310d643fe92ad",
"assets/packages/add_to_google_wallet/assets/svg/buttons/se_add_to_google_wallet_wallet-button.svg": "4f87e7ee56c9aeddf475f1a4c6abd375",
"assets/packages/add_to_google_wallet/assets/svg/buttons/sk_add_to_google_wallet_wallet-button.svg": "b16f6ed9494595a14ade427d4db1b0b1",
"assets/packages/add_to_google_wallet/assets/svg/buttons/sl_add_to_google_wallet_wallet-button.svg": "f89a88aa0b6dfb367c74c621bda15ffd",
"assets/packages/add_to_google_wallet/assets/svg/buttons/sq_add_to_google_wallet_wallet-button.svg": "e568f2f0545c2993b412f7f5b42320ec",
"assets/packages/add_to_google_wallet/assets/svg/buttons/sr_add_to_google_wallet_wallet-button.svg": "fda80812ddb5b99cf767ed19a6ceefea",
"assets/packages/add_to_google_wallet/assets/svg/buttons/th_add_to_google_wallet_wallet-button.svg": "ab9c343ba68db03201e572a234cb5412",
"assets/packages/add_to_google_wallet/assets/svg/buttons/tr_add_to_google_wallet_wallet-button.svg": "f1b61f991a8ab72fe7833d054aab7e97",
"assets/packages/add_to_google_wallet/assets/svg/buttons/uk_add_to_google_wallet_wallet-button.svg": "6835dbf7541d926e3d9367fd67c703d4",
"assets/packages/add_to_google_wallet/assets/svg/buttons/uz_add_to_google_wallet_wallet-button.svg": "9426afa0cd9540106ef93fd46a1fd217",
"assets/packages/add_to_google_wallet/assets/svg/buttons/vi_add_to_google_wallet_wallet-button.svg": "35162663f63d206ae1e2cc30be7cfffc",
"assets/packages/add_to_google_wallet/assets/svg/buttons/zhHK_add_to_google_wallet_wallet-button.svg": "147b0913cc5f029978e33006dcbdee13",
"assets/packages/add_to_google_wallet/assets/svg/buttons/zhTW_add_to_google_wallet_wallet-button.svg": "147b0913cc5f029978e33006dcbdee13",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "813be11049144b344d493e46b84ca027",
"/": "813be11049144b344d493e46b84ca027",
"main.dart.js": "06af29a7cc61e68147fcaf1e87238ddc",
"manifest.json": "5662659e50a64f1342295c3482d4e089",
"version.json": "b3d3776a07098aa85c93bc945d6a9b6f"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
