document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.multi-message').forEach(function (multiMessage) {
        multiMessage.querySelectorAll('textarea').forEach(function (textareaElement) {
            textareaElement.addEventListener('change', function () {
                console.info('textarea', this, this.value, this.value.length);
                if (this.value.trim().length === 0 && multiMessage.querySelectorAll('textarea').length > 2) {
                    this.remove();
                }
            });
        });
        function maybeAddNextTextarea() {
            console.info('textarea', this, this.value, this.value.length);
            if (this.value.trim().length === 0) {
                return;
            }
            const fieldName = this.getAttribute('id').split('-')[0];
            this.removeEventListener('change', maybeAddNextTextarea);
            const i = Number.parseInt(this.dataset.i) + 1;
            const nextTextarea = document.createElement('textarea');
            nextTextarea.dataset.i = i;
            nextTextarea.setAttribute('height', 5);
            nextTextarea.setAttribute('id', `${fieldName}-${i + 1}`);
            nextTextarea.setAttribute('maxlength', 4096);
            nextTextarea.setAttribute('name', `${fieldName}[]`);
            nextTextarea.addEventListener('change', maybeAddNextTextarea);
            console.info(nextTextarea);
            this.after(nextTextarea);
        }
        multiMessage.querySelector('textarea').addEventListener('change', maybeAddNextTextarea);
    })
})