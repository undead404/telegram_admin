document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll(".form.message").forEach(function (form) {
        const firstTextarea = form.querySelector("textarea");
        const imageInput = form.querySelector('#message_image');
        if (imageInput.files && imageInput.files.length > 0) {
            firstTextarea.setAttribute("maxlength", 200);
        }
        imageInput.addEventListener('change', function () {
            firstTextarea.setAttribute("maxlength", (this.files && this.files.length > 0) ? 200 : 4096);
        });
    })
})