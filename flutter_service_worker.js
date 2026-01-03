'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "744183a586a942834b3290f9b0c64f83",
"version.json": "1f1cdd0b6b7be7b569b329c1de531c5b",
"index.html": "0c64a19a459b7f29f713b99debe60de1",
"/": "0c64a19a459b7f29f713b99debe60de1",
"main.dart.js": "3023d37e7f03d5128609158999904bca",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"README.md": "7054ba2d4717f6a5ffdbd005f0601f02",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "4e75ed5245bb86007accf1b4599b5c6b",
".git/config": "e23a99f481185fec03f10ce78d3c813e",
".git/objects/92/c9821d58ee4e1c22a9027a219ad158c583dbcb": "8b1f441b378b26a5c78466e2a1583568",
".git/objects/0c/1d7bbcf68745b8beb127160e962cef276b55a9": "4667a886fb26980f2d1b6dc714ee0b10",
".git/objects/68/43fddc6aef172d5576ecce56160b1c73bc0f85": "2a91c358adf65703ab820ee54e7aff37",
".git/objects/6f/7661bc79baa113f478e9a717e0c4959a3f3d27": "985be3a6935e9d31febd5205a9e04c4e",
".git/objects/03/6430e751515169a45d74bfe2e76d3c1a113c1d": "0587e4eb3cb33828aaae92fd909c0f86",
".git/objects/69/b2023ef3b84225f16fdd15ba36b2b5fc3cee43": "6ccef18e05a49674444167a08de6e407",
".git/objects/51/03e757c71f2abfd2269054a790f775ec61ffa4": "d437b77e41df8fcc0c0e99f143adc093",
".git/objects/93/b363f37b4951e6c5b9e1932ed169c9928b1e90": "c8d74fb3083c0dc39be8cff78a1d4dd5",
".git/objects/0e/e535603f646f8b50247266845fae564afee84b": "36b1b504f5054d00ddaf820b14f5c886",
".git/objects/34/82c55d164bb829e1a33b085bc787cc0bf2762d": "5f7c9d0c48e655b37e212c912c9e912e",
".git/objects/d9/5b1d3499b3b3d3989fa2a461151ba2abd92a07": "a072a09ac2efe43c8d49b7356317e52e",
".git/objects/ad/ced61befd6b9d30829511317b07b72e66918a1": "37e7fcca73f0b6930673b256fac467ae",
".git/objects/d7/f12c184aea03b5740129faed5bbf300eac56d3": "d3f33a627977000d589746d4ae7206ce",
".git/objects/d7/7cfefdbe249b8bf90ce8244ed8fc1732fe8f73": "9c0876641083076714600718b0dab097",
".git/objects/d0/4b04ec3ed46b10cb2615438b724229db345b16": "1865445197d6100f226cde43e4e66a20",
".git/objects/d0/b891fbc239bd10ccffec8bde073a15ba8614c3": "d17517df88a027448a0da8b053c92d2d",
".git/objects/df/d66f394f22e5181b1874f32ba8aa947476bcd5": "2876e0e6da49a4b8a6b60aa0c0dcb8f1",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d8/f4d8cede1761c86674ae70299fdb8c70bda373": "c040617f9fc77864a37758dec7abd380",
".git/objects/e5/19c0357277acb22fdc49098a236533aea67568": "41110b6079b25731c2926b48760bcac3",
".git/objects/e5/f9957579ca507dea55e0370a64e96dc849599a": "886b64d23c55223ae65e0b2fbd631676",
".git/objects/e2/cc8eab7935e8dbd0d3754151e42435dd76dbf8": "4fafcb2a82f528527f3f14249293ff15",
".git/objects/f3/3e0726c3581f96c51f862cf61120af36599a32": "afcaefd94c5f13d3da610e0defa27e50",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/c7/02b6725372606f2f597039371ed7c0a9476a5d": "f8d79a93b3d3e2cbf39790086d13e1d7",
".git/objects/c7/5188711e9467b5311c8b2a68e1f112cbe73e57": "2357434ae8b8ad8bdc1a174b10e7a350",
".git/objects/fd/05cfbc927a4fedcbe4d6d4b62e2c1ed8918f26": "5675c69555d005a1a244cc8ba90a402c",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/objects/ca/0bd8076f3adbdbd02f3e023382b6af857b9acb": "874b087e913980536bb320222354df67",
".git/objects/c8/9f013bb93da8347a39ec4ac9c0c4cf02bf3da0": "a432183b9420f160c70b37f2f2920b90",
".git/objects/c8/3af99da428c63c1f82efdcd11c8d5297bddb04": "144ef6d9a8ff9a753d6e3b9573d5242f",
".git/objects/c1/d1b5701ae90c9828f46107f4ad888d77e7d005": "46ff0254dc33db7b48a2702d54d238f8",
".git/objects/7c/3463b788d022128d17b29072564326f1fd8819": "37fee507a59e935fc85169a822943ba2",
".git/objects/42/40b70474864fbacbaa991f845ff8db02a6e397": "ad0b465b2ec93b50d22f4430f5facf4d",
".git/objects/1a/7d474694ed969ecc0661d492239cd13eb1993f": "48c663bfa4fc2baa4a210c99572be916",
".git/objects/17/99071fee62779a45679632bdcc3f31d193feb2": "c07b84c282901eb9c5cf916d72daf01b",
".git/objects/8f/91cb2f992b1081337dff2a8e25dc3286946f1b": "cb70e6cf568eb2dcd17b1e29b9c56291",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/10/4e642f290c70d462474a924f643306635e3cbd": "e4a43b68d035de71ba59b753198a84af",
".git/objects/4c/7f5dd2974ed9e77a79340f0ee14065a5fea7b9": "4bb5618c94cb2c4b8a9865432ec542b5",
".git/objects/21/e91fae9ed2d56030a3f2dd057b2901677d1155": "59568d85e49cc71f65b7a07fb114872c",
".git/objects/44/b54582dc62c73e3bed8253267bc095df63af66": "328a236a2d18d9fbff190c68319b1b75",
".git/objects/2f/3c7b01d6787138244131a58b74e5235d2b754c": "b47ca9af0488290367bd25e08e063610",
".git/objects/2f/f85422913a031c3bee95dbd2e29d31b40f3c59": "0166658904f89e997af347152f52cbdb",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/9a/1ad9162c0034158329033e97c9f42b6413c2bc": "e4ef402a5fc10cf98d4e31dcb2a53917",
".git/objects/5d/5a64e9cf082cbc5f42afa90bc0788768492789": "e92fdbe202dced831764f1afa912edf0",
".git/objects/65/987aaf87f85582ef1a6a7cec3920e11485f722": "67324e1d6dbf5c9792e2ea99a6ad9787",
".git/objects/62/747ae3bc1c11bf277e4e6212ebb68a4d9dceef": "9920a22a2f9975b7726e8ab8d1627533",
".git/objects/3a/8cda5335b4b2a108123194b84df133bac91b23": "1636ee51263ed072c69e4e3b8d14f339",
".git/objects/53/8adf43b122232396d52ee2336c04119dc2eccc": "efea535ad39a60c0247606dde086934c",
".git/objects/08/27c17254fd3959af211aaf91a82d3b9a804c2f": "360dc8df65dabbf4e7f858711c46cc09",
".git/objects/06/5c878490f73ccbef48c9df3a7e309d2ad63cbb": "552fbe35cfe2516e72cb5c0737132002",
".git/objects/52/736d7fdfd0042fcc2f76c108fdf1f3162aada9": "b2ae87079e5e63f11c17341c840504be",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d5/25e53c974b930579992bf2dfdee022e67a2060": "a1276970caafbfa1d531e0f420e3445b",
".git/objects/d2/5f5cb234ead24f39da498cc15db287a95adc3d": "d0c2c8d8dd00ec89052a00a8c75ed101",
".git/objects/aa/6f6226e0b4c476bb46c473f703da22bd7628d1": "640769ed03af974b7ba5182039e61c23",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/b9/3e39bd49dfaf9e225bb598cd9644f833badd9a": "666b0d595ebbcc37f0c7b61220c18864",
".git/objects/a1/7c7f9276d3b9632b1b9abf619762436c58a86e": "2ad8ff411b011a69662d15121c53205d",
".git/objects/e6/eb8f689cbc9febb5a913856382d297dae0d383": "466fce65fb82283da16cdd7c93059ff3",
".git/objects/e6/71353510f1fc36f5b3c13c8d44db68186d175f": "4b8b75ad6a76950e65fc655ff9e134d4",
".git/objects/fa/f90396ae976ee2fe1526e224c7bcd1f567cf3c": "6e3bf7455ecbd3bef1bf67fc6c0ee994",
".git/objects/f6/e6c75d6f1151eeb165a90f04b4d99effa41e83": "95ea83d65d44e4c524c6d51286406ac8",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/f8/4f82dfd67ecb21efdc318ad3a697fb74808a76": "da4c02a36bcd64160e2a3c1240acf48a",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/77/4f80792bd5c4a8b74a8716de3c5325b83e05b5": "fb7fb778a2581a65f3611873689acbfe",
".git/objects/48/a442bfff59ff460c1271d834ce55b325069a13": "663dba010542d0902790ea4190f24ba6",
".git/objects/70/fac9921fcaa23b5a3c8fa210e88300269212fe": "34624b3de20c38cddf1e6c74e7933222",
".git/objects/23/0ecbba5dff3a7d174a8aa1043b1a1f0e33cce0": "ec41af90781c58c0b9c7b3e4db9d4f10",
".git/objects/85/63aed2175379d2e75ec05ec0373a302730b6ad": "997f96db42b2dde7c208b10d023a5a8e",
".git/objects/76/206e1128803cf12355bf698ac2ed605345f8c4": "ce39bc062c4ebe2d38bcd6b41236ac76",
".git/objects/82/9316bb4ffccb450f7250a900f09d9316494c23": "f27a20a6f9d667d60598d7898ed33ed5",
".git/objects/8e/d3132bc8cabf736df98b037de84f1493238c9b": "ca91af529ad432235e712ee9cc907569",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "c62966a0044372dfe9a8c21d060b4293",
".git/logs/refs/heads/main": "b6389f5fb0208d01ddf3c76a8c445ca9",
".git/logs/refs/remotes/origin/main": "e55f24f8b9eb87c91de84f6639757bd4",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/refs/heads/main": "a766d782a4f73deb40ca578303462fc1",
".git/refs/remotes/origin/main": "a766d782a4f73deb40ca578303462fc1",
".git/index": "94cc48fde92e6b6f2e554ec4b4a526ee",
".git/COMMIT_EDITMSG": "1f9ff7e5f070e5a3604f7005404b2556",
"assets/NOTICES": "c833c293ab22dd494ee167db91cde756",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "cce0bc8dcf44a33f8872ddc76bacc0be",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/AssetManifest.bin": "bd401f778da60d775a3083d3f1bedab9",
"assets/fonts/MaterialIcons-Regular.otf": "89aa86d31fa5ac94b0c3aa8810663aca",
"assets/assets/images/adkar/alarm-clock.png": "454f2ce231ca88b927357c8d05e59ece",
"assets/assets/images/adkar/sunrise.png": "16b218d65f8bf764ef3b491bb5298e6a",
"assets/assets/images/adkar/nature.png": "1fe1d9ae5075a074501c0bfbca0d200e",
"assets/assets/images/adkar/cover.jpg": "5a0beff5d7ef3bcb0a3e856fdac62d4f",
"assets/assets/images/adkar/cover1.jpg": "d31be63e1745606b7c1320697cdf3c79",
"assets/assets/images/adkar/sleeping.png": "b874567e9193e7bdade74ede4331bae4",
"assets/assets/images/namesOfAllah.png": "68e39435bbef72fd8225defca947faa5",
"assets/assets/images/open-hands.png": "12687b0eef3a0b17b2cf0ea04529be2c",
"assets/assets/images/quran.png": "2ab91120c05a2d8ab96181c3baccf474",
"assets/assets/images/suggestion.png": "ae152b26526b12e8929e268262c2e6b5",
"assets/assets/images/logo1.png": "8efaa1ba40b02a5f2c6f0c3f9655e180",
"assets/assets/images/logo.png": "57f692a1510a8a23293e473256ee2cb8",
"assets/assets/db/section.json": "bbdfce4010072f928515b1b7c59413c6",
"assets/assets/db/quran/quranapi.json": "fe62dc4040d11deb5863584fa98c43b8",
"assets/assets/db/Names_Of_Allah/Names_Of_Allah.json": "7c5415299301b36a108e27650c8382e4",
"assets/assets/db/sectionDetails.json": "09569ea56c546c79fe53cf555f8fc17c",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
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
