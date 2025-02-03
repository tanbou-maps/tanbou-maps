<template>
  <!-- ========== HEADER ========== -->
  <header
    class="z-50 flex w-full flex-wrap py-7 md:flex-nowrap md:justify-start"
  >
    <nav
      class="relative mx-auto flex w-full max-w-7xl basis-full flex-wrap items-center px-4 md:grid md:grid-cols-12 md:px-8"
      aria-label="Global"
    >
      <div class="md:col-span-3">
        <!-- Logo -->
        <!-- End Logo -->
      </div>

      <!-- Button Group -->
      <div
        class="ms-auto flex items-center gap-x-2 text-nowrap py-1 md:order-3 md:col-span-3 md:ps-6"
      >
        <a
          href="/sign-out"
          class="group relative inline-flex items-center justify-center overflow-hidden rounded-xl px-3 py-2 text-sm font-medium focus:border-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-100"
        >
          <span
            class="absolute inset-0 h-full w-full bg-gradient-to-br from-gray-300 via-gray-200 to-gray-100"
          ></span>
          <span
            class="ease absolute bottom-0 right-0 mb-32 mr-4 block h-64 w-64 origin-bottom-left translate-x-24 rotate-45 transform rounded-full bg-gray-300 opacity-30 transition duration-500 group-hover:rotate-90"
          ></span>
          <span class="relative text-black">Sign out</span>
        </a>
        <a
          href="#"
          class="group relative inline-flex items-center justify-center overflow-hidden rounded-xl px-3 py-2 text-sm font-medium focus:border-yellow-300 focus:outline-none focus:ring-2 focus:ring-yellow-300"
        >
          <span
            class="absolute inset-0 h-full w-full bg-gradient-to-br from-yellow-500 via-yellow-400 to-yellow-300"
          ></span>
          <span
            class="ease absolute bottom-0 right-0 mb-32 mr-4 block h-64 w-64 origin-bottom-left translate-x-24 rotate-45 transform rounded-full bg-yellow-300 opacity-30 transition duration-500 group-hover:rotate-90"
          ></span>
          <span class="relative text-black">Profile</span>
        </a>
      </div>
      <!-- End Button Group -->

      <!-- Collapse -->
      <div
        id="navbar-collapse-with-animation"
        class="hs-collapse hidden grow basis-full overflow-hidden transition-all duration-300 md:order-2 md:col-span-6 md:block md:w-auto md:basis-auto"
      >
        <div
          class="mt-5 flex flex-col gap-x-0 gap-y-4 text-nowrap md:mt-0 md:flex-row md:items-center md:justify-center md:gap-x-7 md:gap-y-0"
        >
          <div>
            <a
              class="relative inline-block text-black before:absolute before:bottom-0.5 before:start-0 before:-z-[1] before:h-1 before:w-full before:origin-left before:scale-x-0 before:bg-yellow-400 before:transition hover:before:scale-x-100"
              href="/"
              >Home</a
            >
          </div>
          <div>
            <a
              class="relative inline-block text-black before:absolute before:bottom-0.5 before:start-0 before:-z-[1] before:h-1 before:w-full before:origin-left before:scale-x-0 before:bg-yellow-400 before:transition hover:before:scale-x-100"
              href="/spots"
              >Spots</a
            >
          </div>
          <div>
            <a
              class="relative inline-block text-black before:absolute before:bottom-0.5 before:start-0 before:-z-[1] before:h-1 before:w-full before:origin-left before:scale-x-0 before:bg-yellow-400 before:transition hover:before:scale-x-100"
              href="/model-courses"
              >Model Courses</a
            >
          </div>
          <div>
            <a
              class="relative inline-block text-black before:absolute before:bottom-0.5 before:start-0 before:-z-[1] before:h-1 before:w-full before:origin-left before:scale-x-0 before:bg-yellow-400 before:transition hover:before:scale-x-100"
              href="/contacts/new"
              >Contact Us</a
            >
          </div>
        </div>
      </div>
      <!-- End Collapse -->
    </nav>
  </header>
  <!-- ========== END HEADER ========== -->
</template>
