<template>
  <footer class="footer">
    <div class="footer-content">
      <p>© 2023 山东大学威海</p>
      <ul>
        <li><a href="#">回到顶端</a></li>

      </ul>
    </div>
  </footer>
</template>

<style scoped>
/* 底边栏样式 */
.footer {
  background-color: #333;
  color: #fff;
  padding: 20px 0;
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.footer-content p {
  margin: 0;
}

.footer-content ul {
  list-style: none;
  padding: 0;
  display: flex;
}

.footer-content li {
  margin-right: 20px;
}

.footer-content a {
  color: #fff;
  text-decoration: none;
  transition: color 0.3s;
}

.footer-content a:hover {
  color: #ff6600;
}
</style>
