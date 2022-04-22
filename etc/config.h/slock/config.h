/* user and group to drop privileges to */
static const char *user  = "vn36";
static const char *group = "vn36";

/* colors from tokyonight */
static const char *colorname[NUMCOLS] = {
	[INIT] =   "#32344a",     /* after initialization */
	[INPUT] =  "#7da6ff",   /* during input */
	[FAILED] = "#ad8ee6",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
