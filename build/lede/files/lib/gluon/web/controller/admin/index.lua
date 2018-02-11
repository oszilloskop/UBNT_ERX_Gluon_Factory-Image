local e=node()
if not e.target then
e.target=alias("admin")
end
entry({"admin"},alias("admin","upgrade"),_("Advanced settings"),1)
entry({"admin","info"},template("admin/info"),_("Information"),100)
