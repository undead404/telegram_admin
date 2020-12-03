// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import { start as startRailsActivestorage } from '@rails/activestorage';
import { start as startRailsUJS } from '@rails/ujs';
import ReactRailsUJS from 'react_ujs';
import toastr from 'toastr';
import Turbolinks from 'turbolinks';
import '../channels';
import '../stylesheets/application.scss';

startRailsUJS();
Turbolinks.start();
startRailsActivestorage();
global.toastr = toastr;

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../../images', true);
// global.imagePath = (name) => images(name, true);
// Support component names relative to this directory:
const componentRequireContext = require.context('components', true);
// eslint-disable-next-line react-hooks/rules-of-hooks
ReactRailsUJS.useContext(componentRequireContext);
