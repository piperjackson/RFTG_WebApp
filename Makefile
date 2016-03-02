PROGS=rftg learner dumpnet netconv
CFLAGS=$(shell pkg-config --cflags gtk+-2.0) -march=native -g
GTKLIBS=$(shell pkg-config --libs gtk+-2.0)
LDLIBS=-lm
EXPORTS="['_main','_selection_result','_continue_game','_get_status_data','_get_cards_num','_get_card_name','_get_card_image','_get_card_num_powers','_get_card_power_score','_get_card_power_name','_get_callbuffer','_action_check_payment','_choose_pay_prompt','_action_check_goods','_action_check_consume','_action_check_start','_can_prestige','_action_check_upgrade']"
ICONS=launcher-icon-2x.png launcher-icon-3x.png launcher-icon-4x.png apple-touch-icon.png
EXTERNAL=campaign.txt cards.txt images.data
#CC=clang
all: rftg.js icons
progs: $(PROGS)
rftg: ai.o client.o comm.o engine.o gui.o init.o loadsave.o net.o
	$(CC) $(LDFLAGS) $^ $(GTKLIBS) $(LDLIBS) -o $@
learner: learner.o ai.o engine.o init.o net.o
dumpnet: dumpnet.o net.o
netconv: netconv.o net.o
#rftg: rftg.o engine.o init.o loadsave.o net.o ai.o
rftg.js: rftg.bc engine.bc init.bc loadsave.bc net.bc ai.bc
clean:
	rm -f *.o *.bc $(PROGS) rftg.js rftg.js.mem $(ICONS)

%.js: %.bc
	emcc -O3 $^ -o $@ -s EXPORTED_FUNCTIONS=$(EXPORTS) -s NO_EXIT_RUNTIME=1
%.bc: %.c
	emcc -O3 $< -o $@

icons: $(ICONS)
launcher-icon-2x.png: icon.svg
	convert -background none $< -resize 96x96 $@
launcher-icon-3x.png: icon.svg
	convert -background none $< -resize 144x144 $@
launcher-icon-4x.png: icon.svg
	convert -background none $< -resize 192x192 $@
apple-touch-icon.png: icon.svg
	convert -background '#ddd' -bordercolor '#ddd' $< -resize 150x150 -border 15 $@

rftg_webapp.zip: $(ICONS) network fonts rftg.js $(EXTERNAL) rftg.html rftg.js.mem rftg.manifest.json rftg.appcache
	zip -r $@ $^
