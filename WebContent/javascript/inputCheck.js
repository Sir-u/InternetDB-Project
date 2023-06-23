function writeCheck() {
   var inputs = ['title', 'studentName', 'studentPassward', 'memo'];
   var invalidFeedbacks = ['invalidFeedback1', 'invalidFeedback2', 'invalidFeedback3', 'invalidFeedback4'];

   for (var i = 0; i < inputs.length; i++) {
      var input = document.getElementById(inputs[i]);
      var invalidFeedback = document.getElementById(invalidFeedbacks[i]);

      if (input.value === '') {
         input.classList.add('is-invalid');
         invalidFeedback.style.display = 'block';
      } else {
         input.classList.remove('is-invalid');
         invalidFeedback.style.display = 'none';
      }
   }

   form.submit();
}

function writeReplyCheck() {
   var rep_inputs = ['studentName', 'content'];
   var invalidFeedbacks = ['invalidFeedback1', 'invalidFeedback2'];

   for (var i = 0; i < rep_inputs.length; i++) {
      var input = document.getElementById(rep_inputs[i]);
      var invalidFeedback = document.getElementById(invalidFeedbacks[i]);

      if (input.value === '') {
         input.classList.add('is-invalid');
         invalidFeedback.style.display = 'block';
      } else {
         input.classList.remove('is-invalid');
         invalidFeedback.style.display = 'none';
      }
   }

   form.submit();
}

function validateInput() {
   var inputs = ['studentNumber', 'studentPassword', 'studentName', 'gender', 'datepicker', 'studentAge', 'reg_date'];
   var invalidFeedbacks = ['invalidFeedback1', 'invalidFeedback2', 'invalidFeedback3', 'invalidFeedback4', 'invalidFeedback5', 'invalidFeedback6', 'invalidFeedback7'];

   for (var i = 0; i < inputs.length; i++) {
      var input = document.getElementById(inputs[i]);
      var invalidFeedback = document.getElementById(invalidFeedbacks[i]);

      if (input.value === '') {
         input.classList.add('is-invalid');
         invalidFeedback.style.display = 'block';
      } else {
         input.classList.remove('is-invalid');
         invalidFeedback.style.display = 'none';
      }
   }
}

function writePasswardCheck() {
   

   
      var input = document.getElementById("passwordInput");
      var invalidFeedback = document.getElementById("passwordInputFeedback");

      if (input.value === '') {
         input.classList.add('is-invalid');
         invalidFeedback.style.display = 'block';

      } else {
         input.classList.remove('is-invalid');
         invalidFeedback.style.display = 'none';
      }
   
}