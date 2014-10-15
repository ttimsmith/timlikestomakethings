
// Top Bar Navigation

$(".toggleNav").on("click", function() {
    $(".dropNav").toggleClass("MenuIsOpen");
});

/* Payment Form Formatting */

$('input.cc_num').payment('formatCardNumber');
$('input.cc_cvc').payment('formatCardCVC');
