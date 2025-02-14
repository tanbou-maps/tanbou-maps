<template>
  <div class="modal-overlay" @click.self="$emit('close')">
    <div class="modal-content">
      <slot name="content"></slot>
      <button @click="closeModal" class="close-button">閉じる</button>

    </div>
  </div>
</template>

<script>
export default {
  emits: ["close"]
};
</script>

<style scoped>
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal-content {
  background: white;
  padding: 20px;
  border-radius: 8px;
  width: 400px;
  text-align: center;
}
.help-button {
  background: #3498db;
  color: white;
  border: none;
  padding: 10px 15px;
  font-size: 20px;
  border-radius: 50%;
  cursor: pointer;
}

.help-button:hover {
  background: #2980b9;
}

.close-button {
  background: #e74c3c;
  color: white;
  border: none;
  padding: 10px;
  margin-top: 10px;
  cursor: pointer;
}

</style>
