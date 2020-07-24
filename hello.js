addEventListener("fetch", (event) => {
  event.respondWith(hello(event.request))
});

async function hello(request) {
  return new Response("Hello world", {
    status: 200
  });
}
