dest_dir = get_absolute_file_path("build_help.sce");
exec("help" + filesep() + "macros_to_document.sce");
for funcname = macros_to_document
    help_from_sci("macros" + filesep() + funcname, dest_dir);
end
tbx_build_help(TOOLBOX_TITLE, dest_dir);
clear macros_to_document dest_dir
