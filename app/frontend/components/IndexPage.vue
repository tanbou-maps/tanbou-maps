<template>
  <!-- ========== MAIN CONTENT ========== -->
  <main id="content">
    <!-- Slider -->
    <div class="px-4 lg:px-8">
      <div
        data-hs-carousel='{
          "loadingClasses": "opacity-0"
        }'
        class="relative"
      >
        <div
          class="hs-carousel relative h-96 w-full overflow-hidden rounded-2xl lg:min-h-screen"
        >
          <!-- Photo -->
          <img
            class="h-full w-full object-cover blur-sm"
            src="@/images/image_background.jpg"
            alt="image_background"
          />
          <!-- End Photo -->

          <!-- Title and Buttons -->
          <div
            class="absolute inset-0 flex flex-col items-center justify-center text-center text-white"
          >
            <h1 class="mb-4 text-8xl">Tanbou Maps</h1>
            <h2 class="mb-8 text-2xl">- あなたの新しい旅のために -</h2>
            <a
              href="#latest-spots"
              class="group relative inline-flex items-center overflow-hidden rounded-xl border-2 border-yellow-300 px-12 py-3 text-lg font-medium text-yellow-300 hover:border-yellow-400 hover:text-black focus:border-yellow-300 focus:outline-none focus:ring-2 focus:ring-yellow-300"
            >
              <span
                class="duration-400 ease absolute left-0 top-1/2 block h-0 w-full bg-yellow-400 opacity-100 transition-all group-hover:top-0 group-hover:h-full"
              ></span>
              <span
                class="ease absolute right-0 flex h-10 w-10 translate-x-full transform items-center justify-start duration-300 group-hover:translate-x-0"
              >
                <svg
                  class="h-5 w-5"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M14 5l7 7m0 0l-7 7m7-7H3"
                  ></path>
                </svg>
              </span>
              <span class="relative">Let's Go!</span>
            </a>
          </div>
          <!-- End Title and Buttons -->
        </div>
      </div>
    </div>
    <!-- End Slider -->

    <!-- Works -->
    <div class="mx-auto max-w-7xl px-4 py-12 lg:px-8 lg:py-24">
      <div class="mx-auto mb-6 max-w-2xl text-center sm:mb-10">
        <h1
          id="latest-spots"
          class="text-2xl font-medium text-black sm:text-4xl"
        >
          最新のスポット
        </h1>
      </div>

      <!-- Card Grid -->
      <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 md:gap-8 lg:gap-12">
        <!-- Card -->
        <div v-for="spot in latestSpots" :key="spot.id" class="group block">
          <div class="overflow-hidden rounded-2xl bg-gray-100">
            <img
              v-if="spot.images && spot.images.length > 0"
              class="h-48 w-full rounded-2xl object-cover transition-transform duration-500 ease-in-out group-hover:scale-105 md:h-64 lg:h-96"
              :src="spot.images[0]"
              :alt="spot.name"
            />
          </div>

          <div class="pt-4">
            <h3
              class="relative inline-block text-lg font-medium text-black before:absolute before:bottom-0.5 before:start-0 before:-z-[1] before:h-1 before:w-full before:origin-left before:scale-x-0 before:bg-yellow-400 before:transition group-hover:before:scale-x-100"
            >
              {{ spot.name }}
            </h3>
            <p class="mt-1 truncate text-gray-600">{{ spot.description }}</p>

            <div class="mt-3 flex flex-wrap gap-2">
              <span
                class="rounded-xl border border-gray-200 bg-white px-3 py-1.5 text-xs text-gray-600 sm:text-sm"
              >
                tag1
              </span>
              <span
                class="rounded-xl border border-gray-200 bg-white px-3 py-1.5 text-xs text-gray-600 sm:text-sm"
              >
                tag2
              </span>
              <span
                class="rounded-xl border border-gray-200 bg-white px-3 py-1.5 text-xs text-gray-600 sm:text-sm"
              >
                tag3
              </span>
            </div>
          </div>
        </div>
        <!-- End Card -->
      </div>
      <!-- End Card Grid -->

      <div class="mt-10 text-center lg:mt-20">
        <a
          class="relative inline-block font-medium text-black before:absolute before:bottom-0.5 before:start-0 before:-z-[1] before:h-1 before:w-full before:bg-yellow-300 hover:before:bg-black focus:outline-none focus:before:bg-black md:text-lg"
          href="/spots"
        >
          すべてのスポットを見る
        </a>
      </div>
    </div>
    <!-- End Works -->

    <!-- Testimonials -->
    <div class="bg-black">
      <div class="mx-auto max-w-7xl px-4 py-12 lg:px-8 lg:py-24">
        <blockquote class="mx-auto max-w-4xl">
          <p class="mb-6 md:text-lg">
            <span class="font-semibold text-yellow-400">Model </span>
            <span class="text-neutral-500">Courses</span>
          </p>

          <p
            class="text-xl text-white sm:text-2xl md:text-3xl md:leading-normal"
          >
            "人間は夢を持ち、前へ歩き続ける限り、余生はいらない"<br />
            - 伊能忠敬
          </p>

          <footer class="mt-6 md:mt-10">
            <div class="border-neutral-700">
              <a
                type="button"
                class="group inline-flex items-center gap-x-3 text-sm text-neutral-400 focus:outline-none disabled:pointer-events-none disabled:opacity-50"
                href="model-courses"
              >
                <span
                  class="flex size-8 flex-col items-center justify-center rounded-full bg-white text-black group-hover:bg-yellow-300 group-focus:bg-yellow-300 md:size-10"
                >
                  <svg
                    class="size-5 flex-shrink-0"
                    xmlns="http://www.w3.org/2000/svg"
                    width="16"
                    height="16"
                    fill="currentColor"
                    viewBox="0 0 16 16"
                  >
                    <path
                      d="M15.817.113a.5.5 0 0 0-.459-.04l-3.857 1.543-4.8-1.6a.5.5 0 0 0-.316 0l-4.8 1.6L.642.073a.5.5 0 0 0-.642.766v14.322a.5.5 0 0 0 .642.766l3.857-1.543 4.8 1.6a.5.5 0 0 0 .316 0l4.8-1.6 3.857 1.543a.5.5 0 0 0 .642-.766V.879a.5.5 0 0 0-.183-.766zM6 2.5v11l-4-1.333V1.167L6 2.5zm5 11v-11l4-1.333v11.667L11 13.5z"
                    />
                  </svg>
                </span>
                モデルコースを見てみる
              </a>
            </div>
          </footer>
        </blockquote>
      </div>
    </div>
    <!-- End Testimonials -->

    <!-- Contact -->
    <div class="mx-auto max-w-7xl px-4 py-12 lg:px-8 lg:py-24">
      <div class="mx-auto mb-6 max-w-2xl text-center sm:mb-10">
        <h2 class="text-2xl font-medium text-black sm:text-4xl">Contact us</h2>
      </div>

      <div
        class="grid grid-cols-1 gap-6 md:gap-8 lg:grid-cols-2 lg:items-center lg:gap-12"
      >
        <div class="group overflow-hidden rounded-2xl bg-gray-100">
          <img
            class="h-auto w-full rounded-2xl object-cover transition-transform duration-500 ease-in-out group-hover:scale-105"
            src="@/images/image_contact_page_model.jpg"
            alt="Image Description"
          />
        </div>
        <!-- End Col -->

        <div class="space-y-8 lg:space-y-16">
          <div>
            <h3 class="mb-5 font-semibold text-black">Our address</h3>

            <!-- Grid -->
            <div class="grid gap-4 sm:grid-cols-2 sm:gap-6 md:gap-8 lg:gap-12">
              <div class="flex gap-4">
                <svg
                  class="size-5 flex-shrink-0 text-gray-500"
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="1.5"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                  <path
                    d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z"
                  ></path>
                  <circle cx="12" cy="10" r="3"></circle>
                </svg>

                <div class="grow">
                  <p class="text-sm text-gray-600">Yokohama, Kanagawa</p>
                  <address class="mt-1 not-italic text-black">
                    1-8-14 Tanmachi<br />
                    Kanagawa Ward
                  </address>
                </div>
              </div>
            </div>
            <!-- End Grid -->
          </div>

          <div>
            <h3 class="mb-5 font-semibold text-black">Our contacts</h3>

            <!-- Grid -->
            <div class="grid gap-4 sm:grid-cols-2 sm:gap-6 md:gap-8 lg:gap-12">
              <div class="flex gap-4">
                <svg
                  class="size-5 flex-shrink-0 text-gray-500"
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="1.5"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                  <path
                    d="M21.2 8.4c.5.38.8.97.8 1.6v10a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V10a2 2 0 0 1 .8-1.6l8-6a2 2 0 0 1 2.4 0l8 6Z"
                  ></path>
                  <path d="m22 10-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 10"></path>
                </svg>

                <div class="grow">
                  <p class="text-sm text-gray-600">Email us</p>
                  <p>
                    <a
                      href="/contacts/new"
                      class="relative inline-block font-medium text-black before:absolute before:bottom-0.5 before:start-0 before:-z-[1] before:h-1 before:w-full before:bg-yellow-300 hover:before:bg-black focus:outline-none focus:before:bg-black"
                    >
                      hello@example.so
                    </a>
                  </p>
                </div>
              </div>

              <div class="flex gap-4">
                <svg
                  class="size-5 flex-shrink-0 text-gray-500"
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                  <path
                    d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"
                  />
                </svg>

                <div class="grow">
                  <p class="text-sm text-gray-600">Call us</p>
                  <p>
                    <a
                      class="relative inline-block font-medium text-black before:absolute before:bottom-0.5 before:start-0 before:-z-[1] before:h-1 before:w-full before:bg-yellow-300 hover:before:bg-black focus:outline-none focus:before:bg-black"
                      href="/contacts/new"
                    >
                      +81 45 311 6821
                    </a>
                  </p>
                </div>
              </div>
            </div>
            <!-- End Grid -->
          </div>
        </div>
        <!-- End Col -->
      </div>
    </div>
    <!-- End Contact -->
  </main>
  <!-- ========== END MAIN CONTENT ========== -->
</template>

<script>
export default {
  data() {
    return {
      latestSpots: [],
    };
  },
  mounted() {
    const latestSpotsData =
      document.getElementById("index-page").dataset.latestSpots;
    if (latestSpotsData) {
      this.latestSpots = JSON.parse(latestSpotsData);
    }
  },
};
</script>
