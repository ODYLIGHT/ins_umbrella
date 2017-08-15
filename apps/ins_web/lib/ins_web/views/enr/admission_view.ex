defmodule InsWeb.ENR.AdmissionView do
  use InsWeb, :view

  alias Ins.ENR
  
  def enroller_name(%ENR.Admission{enroller: enroller}) do
    enroller.user.name
  end
end
