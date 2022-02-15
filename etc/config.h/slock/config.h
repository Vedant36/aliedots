/* user and group to drop privileges to */
static const char *user  = "vn36";
static const char *group = "vn36";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#282d3e",     /* after initialization */
	[INPUT] =  "#82AAFF",   /* during input */
	[FAILED] = "#F07178",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
