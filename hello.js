addEventListener("fetch", (event) => {
  event.respondWith(hello(event.request))
});

const text = `Secret: ${name.secret}`

async function hello(request) {
  return new Response("Hello world", {
    status: 200
  });
}
