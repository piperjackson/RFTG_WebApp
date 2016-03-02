/*
 * Race for the Galaxy AI
 * 
 * Copyright (C) 2009-2011 Keldon Jones
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include "net.h"

int main(int argc, char *argv[])
{
	net learner;
	FILE *fff;
	int header[4], reverse = 0;
	char buf[1024];

	if (!strcmp(argv[1], "-r"))
	{
		reverse = 1;

		argv++;
	}
	
	fff = fopen(argv[1], "r");

	if (reverse)
	{
		fread(header, sizeof(int), 4, fff);
	}
	else
	{
		fgets(buf, 1024, fff);

		sscanf(buf, "%d %d %d", header + 1, header + 2, header + 3);
	}

	fclose(fff);

	make_learner(&learner, header[1], header[2], header[3]);

	load_net(&learner, argv[1]);

	if (reverse)
	{
		save_net(&learner, argv[2]);
	}
	else
	{
		save_net_bin(&learner, argv[2]);
	}

	return 0;
}
