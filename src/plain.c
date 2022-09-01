/*
 * file: src/plain.c
 * author: Josue Teodoro Moreira <teodoro.josue@protonmail.ch>
 * date: 28 August, 2022
 *
 * Copyright (C) 2022, Josue Teodoro Moreira                               
 *                                                                         
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by    
 * the Free Software Foundation, either version 3 of the License, or       
 * (at your option) any later version.                                     
 *                                                                         
 * This program is distributed in the hope that it will be useful,         
 * but WITHOUT ANY WARRANTY; without even the implied warranty of          
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the          
 * GNU General Public License for more details.                            
 *                                                                         
 * You should have received a copy of the GNU General Public License       
 * along with this program.	 If not, see <https://www.gnu.org/licenses/>.
 */

#include "plain.h"

__attribute__ ((constructor))
void plain_init
(
  void
)
{
  struct plain_log_t log;
  log.type = PLAIN_LOG_INFO;
  log.msg = malloc(255 * sizeof(char));
  sprintf(log.msg, "Plain framework version %s\nAuthor: Josue Teodoro Moreira\nContact: <teodoro.josue@protonmail.ch>", PLAIN_VERSION);

  plain_log(&log);
}

__attribute__ ((destructor))
void plain_end
(
  void
)
{
}
