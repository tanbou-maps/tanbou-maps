<template>
  <!-- ========== HEADER ========== -->
  <header
    class="z-50 flex w-full flex-wrap py-7 md:flex-nowrap md:justify-start"
  >
    <nav
      class="relative mx-auto flex w-full max-w-7xl basis-full flex-wrap items-center px-4 md:grid md:grid-cols-12 md:px-6 md:px-8"
      aria-label="Global"
    >
      <div class="md:col-span-3">
        <!-- Logo -->
        <!-- End Logo -->
      </div>

      <!-- Button Group -->
      <div
        class="ms-auto flex items-center gap-x-2 py-1 md:order-3 md:col-span-3 md:ps-6"
      >
        <button
          type="button"
          class="inline-flex items-center gap-x-2 rounded-xl border border-gray-200 px-3 py-2 text-sm font-medium text-black hover:bg-gray-100 disabled:pointer-events-none disabled:opacity-50"
        >
          Sign out
        </button>
        <button
          type="button"
          class="inline-flex items-center gap-x-2 rounded-xl border border-transparent bg-lime-400 px-3 py-2 text-sm font-medium text-black transition hover:bg-lime-500 focus:bg-lime-500 focus:outline-none disabled:pointer-events-none disabled:opacity-50"
        >
          Profile
        </button>

        <div class="md:hidden">
          <button
            type="button"
            class="hs-collapse-toggle flex size-[38px] items-center justify-center rounded-xl border border-gray-200 text-sm font-semibold text-black hover:bg-gray-100 disabled:pointer-events-none disabled:opacity-50"
            data-hs-collapse="#navbar-collapse-with-animation"
            aria-controls="navbar-collapse-with-animation"
            aria-label="Toggle navigation"
          >
            <svg
              class="hs-collapse-open:hidden size-4 flex-shrink-0"
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
              <line x1="3" x2="21" y1="6" y2="6" />
              <line x1="3" x2="21" y1="12" y2="12" />
              <line x1="3" x2="21" y1="18" y2="18" />
            </svg>
            <svg
              class="hs-collapse-open:block hidden size-4 flex-shrink-0"
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
              <path d="M18 6 6 18" />
              <path d="m6 6 12 12" />
            </svg>
          </button>
        </div>
      </div>
      <!-- End Button Group -->

      <!-- Collapse -->
      <div
        id="navbar-collapse-with-animation"
        class="hs-collapse hidden grow basis-full overflow-hidden transition-all duration-300 md:order-2 md:col-span-6 md:block md:w-auto md:basis-auto"
      >
        <div
          class="mt-5 flex flex-col gap-x-0 gap-y-4 md:mt-0 md:flex-row md:items-center md:justify-center md:gap-x-7 md:gap-y-0"
        >
          <div>
            <a
              class="relative inline-block text-black before:absolute before:bottom-0.5 before:start-0 before:-z-[1] before:h-1 before:w-full before:bg-lime-400"
              href="#"
              aria-current="page"
              >Work</a
            >
          </div>
          <div>
            <a class="inline-block text-black hover:text-gray-600" href="#"
              >Services</a
            >
          </div>
          <div>
            <a class="inline-block text-black hover:text-gray-600" href="#"
              >About</a
            >
          </div>
          <div>
            <a class="inline-block text-black hover:text-gray-600" href="#"
              >Careers</a
            >
          </div>
          <div>
            <a class="inline-block text-black hover:text-gray-600" href="#"
              >Blog</a
            >
          </div>
        </div>
      </div>
      <!-- End Collapse -->
    </nav>
  </header>
  <!-- ========== END HEADER ========== -->
</template>
