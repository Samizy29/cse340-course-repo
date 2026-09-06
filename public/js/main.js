const highlightCurrentPage = () => {
  const links = document.querySelectorAll('nav a');
  const currentPath = window.location.pathname;

  links.forEach((link) => {
    if (link.getAttribute('href') === currentPath) {
      link.classList.add('active');
    }
  });
};

document.addEventListener('DOMContentLoaded', highlightCurrentPage);