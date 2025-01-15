<!-- <template>
  <!-- <h1>aaaa</h1> -->
<!-- <div>
    <input type="file" @change="onFileChange" />
    <button @click="uploadImage">Upload</button>
  </div>
</template> -->
-->

<!-- <script>
export default {
  data() {
    return {
      selectedFile: null,
    };
  },
  methods: {
    onFileChange(event) {
      this.selectedFile = event.target.files[0];
    },
    async uploadImage() {
      const formData = new FormData();
      formData.append("profile_picture", this.selectedFile);

      try {
        const response = await fetch("/user-profile-crud", {
          method: "POST",
          body: formData,
          headers: {
            Accept: "application/json",
          },
        });

        if (!response.ok) {
          throw new Error("Network response was not ok");
        }

        const data = await response.json();
        console.log(data);
      } catch (error) {
        console.error(
          "There has been a problem with your fetch operation:",
          error,
        );
      }
    },
  },
};
</script> -->
