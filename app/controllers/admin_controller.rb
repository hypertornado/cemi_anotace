class AdminController < ApplicationController
  http_basic_authenticate_with name: "cemi", password: "cemi85"
end