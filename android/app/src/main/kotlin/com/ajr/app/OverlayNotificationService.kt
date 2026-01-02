package com.ajr.app

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.graphics.PixelFormat
import android.os.Build
import android.os.IBinder
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.WindowManager
import android.widget.LinearLayout
import android.widget.TextView
import androidx.core.app.NotificationCompat

class OverlayNotificationService : Service() {
    companion object {
        const val CHANNEL_ID = "overlay_notification_channel"
        const val NOTIFICATION_ID = 2
        const val ACTION_START_LOOP = "START_LOOP"
        const val ACTION_SHOW_OVERLAY = "SHOW_OVERLAY"
        const val ACTION_UPDATE_SETTINGS = "UPDATE_SETTINGS"
    }

    private var windowManager: WindowManager? = null
    private var overlayView: View? = null
    private val handler = android.os.Handler(android.os.Looper.getMainLooper())
    private var runnable: Runnable? = null
    private var repeatInterval: Long = 15 * 60 * 1000L // Default 15 minutes

    private val adkarList = listOf(
        "اللَّهُمَّ إنِّي أَسْأَلُكَ الهُدَى وَالتُّقَى، وَالْعَفَافَ وَالْغِنَى",
        "رَبِّ إِنِّي أَعُوذُ بِكَ أَنْ أَسْأَلَكَ مَا لَيْسَ لِي بِهِ عِلْمٌ ۖ وَإِلَّا تَغْفِرْ لِي وَتَرْحَمْنِي أَكُن مِّنَ الْخَاسِرِينَ",
        "رَبَّنَا أَتْمِمْ لَنَا نُورَنَا وَاغْفِرْ لَنَا ۖ إِنَّكَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ",
        "رَّبِّ أَنزِلْنِي مُنزَلًا مُّبَارَكًا وَأَنتَ خَيْرُ الْمُنزِلِينَ",
        "اللَّهمَّ إنِّي أسألُك أنِّي أَشهَدُ أنَّك أنت اللهُ، لا إلهَ إلَّا أنت، الأحدُ الصمدُ، الذي لم يَلِدْ ولم يولَدْ، ولم يكُنْ له كُفوًا أحدٌ",
        "اللَّهُمَّ إنِّي أعُوذُ بكَ مِنَ الهَمِّ والحَزَنِ، والعَجْزِ والكَسَلِ، والبُخْلِ، والجُبْنِ، وضَلَعِ الدَّيْنِ، وغَلَبَةِ الرِّجالِ",
        "رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ",
        "لَّا إِلَٰهَ إِلَّا أَنتَ سُبْحَانَكَ إِنِّي كُنتُ مِنَ الظَّالِمِينَ",
        "رَّبِّ زِدْنِي عِلْمًا",
        "اللَّهمَّ إنِّي أسألُك من خيرِ ما أُمِرَتْ بِه وأعوذُ بِك من شرِّ ما أُمِرَت بِه",
        "اللهمَّ إني أسألُك من كل خيرٍ خزائنُه بيدِك، وأعوذُ بك من كل شرٍّ خزائنُه بيدِك",
        "رَبِّ أَوْزِعْنِي أَنْ أَشْكُرَ نِعْمَتَكَ الَّتِي أَنْعَمْتَ عَلَيَّ وَعَلَىٰ وَالِدَيَّ وَأَنْ أَعْمَلَ صَالِحًا تَرْضَاهُ وَأَصْلِحْ لِي فِي ذُرِّيَّتِي ۖ إِنِّي تُبْتُ إِلَيْكَ وَإِنِّي مِنَ الْمُسْلِمِينَ",
        "رَبَّنَا هَبْ لَنَا مِنْ أَزْوَاجِنَا وَذُرِّيَّاتِنَا قُرَّةَ أَعْيُنٍ وَاجْعَلْنَا لِلْمُتَّقِينَ إِمَامًا",
        "اللَّهُمَّ إنِّي أعُوذُ بكَ مِنَ البُخْلِ، وأَعُوذُ بكَ مِنَ الجُبْنِ، وأَعُوذُ بكَ أنْ أُرَدَّ إلى أرْذَلِ العُمُرِ، وأَعُوذُ بكَ مِن فِتْنَةِ الدُّنْيَا -يَعْنِي فِتْنَةَ الدَّجَّالِ- وأَعُوذُ بكَ مِن عَذَابِ القَبْرِ",
        "رَبَّنَا اغْفِرْ لَنَا ذُنُوبَنَا وَإِسْرَافَنَا فِي أَمْرِنَا وَثَبِّتْ أَقْدَامَنَا وَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ",
        "رَبِّ هَبْ لِي مِن لَّدُنكَ ذُرِّيَّةً طَيِّبَةً ۖ إِنَّكَ سَمِيعُ الدُّعَاءِ",
        "رَبَّنَا لَا تُزِغْ قُلُوبَنَا بَعْدَ إِذْ هَدَيْتَنَا وَهَبْ لَنَا مِن لَّدُنكَ رَحْمَةً",
        "قَالَ رَبِّ اشْرَحْ لِي صَدْرِي*وَيَسِّرْ لِي أَمْرِي",
        "اللَّهُمَّ إنِّي أَعُوذُ بكَ مِن زَوَالِ نِعْمَتِكَ، وَتَحَوُّلِ عَافِيَتِكَ، وَفُجَاءَةِ نِقْمَتِكَ، وَجَمِيعِ سَخَطِكَ",
        "اللَّهمَّ إنِّي أعوذُ بِك من شرِّ ما عَمِلتُ ، ومن شرِّ ما لم أعمَلْ",
        "رَبِّ نَجِّنِي مِنَ الْقَوْمِ الظَّالِمِينَ",
        "رَبِّ هَبْ لِي حُكْمًا وَأَلْحِقْنِي بِالصَّالِحِينَ",
        "رَّبِّ أَعُوذُ بِكَ مِنْ هَمَزَاتِ الشَّيَاطِينِ",
        "اللَّهُمَّ اجْعَلْ في قَلْبِي نُورًا، وفي بَصَرِي نُورًا، وفي سَمْعِي نُورًا، وعَنْ يَمِينِي نُورًا، وعَنْ يَسارِي نُورًا، وفَوْقِي نُورًا، وتَحْتي نُورًا، وأَمامِي نُورًا، وخَلْفِي نُورًا، واجْعَلْ لي نُورًا",
        "اللَّهمَّ أحسَنتَ خَلقي فأحسِن خُلُقي",
        "رَبِّ اجْعَلْنِي مُقِيمَ الصَّلَاةِ وَمِن ذُرِّيَّتِي ۚ رَبَّنَا وَتَقَبَّلْ دُعَائِي",
        "رَبَّنَا أَفْرِغْ عَلَيْنَا صَبْرًا وَثَبِّتْ أَقْدَامَنَا وَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ",
        "رَبَّنَا تَقَبَّلْ مِنَّا إِنَّكَ أَنْتَ السَّمِيعُ الْعَلِيمُ",
        "وَتُبْ عَلَيْنَا إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيمُ",
        "اللهمَّ احفَظْني بالإسلام قائمًا، واحفَظْني بالإسلام قاعدًا، واحفظْني بالإسلام راقدًا، ولا تُشْمِتْ بي عدوًّا ولا حاسدًا",
        "اللَّهُمَّ أحْيِنِي ما كانَتِ الحَياةُ خَيْرًا لِي، وتَوَفَّنِي إذا كانَتِ الوَفاةُ خَيْرًا لِي",
        "رَبِّ أَوْزِعْنِي أَنْ أَشْكُرَ نِعْمَتَكَ الَّتِي أَنْعَمْتَ عَلَيَّ وَعَلَىٰ وَالِدَيَّ وَأَنْ أَعْمَلَ صَالِحًا تَرْضَاهُ وَأَدْخِلْنِي بِرَحْمَتِكَ فِي عِبَادِكَ الصَّالِحِينَ",
        "اللَّهُمَّ أعنَّا على شُكْرِكَ وذِكْرِكَ، وحُسنِ عبادتِكَ",
        "اللهمَّ اكفِنِي بحalalِكَ عن حرَامِكَ، وأغْنِنِي بفَضْلِكَ عمَّن سواكَ",
        "رَبَّنَا آتِنَا مِن لَّدُنكَ رَحْمَةً وَهَيِّئْ لَنَا مِنْ أَمْرِنَا رَشَدًا",
        "اللَّهمَّ إنِّي أعوذُ بِكَ منَ الفقرِ ، والقلَّةِ ، والذِّلَّةِ ، وأعوذُ بِكَ من أن أظلِمَ ، أو أُظلَمَ"
    )

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        createNotificationChannel()
        startForeground(NOTIFICATION_ID, createNotification())

        when (intent?.action) {
            ACTION_START_LOOP -> {
                repeatInterval = intent.getLongExtra("interval_input", 15 * 60 * 1000L)
                startPeriodicNotifications()
            }
            ACTION_UPDATE_SETTINGS -> {
                // Settings updated, maybe refresh view if visible
                if (overlayView != null) {
                    val sharedPreferences = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
                    val textSize = sharedPreferences.getFloat("flutter.overlay_text_size", 18f)
                    val textColor = sharedPreferences.getInt("flutter.overlay_text_color", Color.BLACK)
                    val backgroundColor = sharedPreferences.getInt("flutter.overlay_background_color", Color.WHITE)
                    val opacity = sharedPreferences.getFloat("flutter.overlay_background_opacity", 1.0f)
                    
                    val alpha = (opacity * 255).toInt()
                    val finalBgColor = (alpha shl 24) or (backgroundColor and 0x00FFFFFF)
                    
                    updateOverlayStyle(textSize, textColor, finalBgColor)
                }
            }
            else -> {
                // Direct show request or default
                val adkarText = intent?.getStringExtra("adkar_text")
                if (adkarText != null) {
                    val textSize = intent.getFloatExtra("text_size", 18f)
                    val textColor = intent.getIntExtra("text_color", Color.BLACK)
                    val backgroundColor = intent.getIntExtra("background_color", Color.WHITE)
                    showOverlay(adkarText, textSize, textColor, backgroundColor)
                }
            }
        }

        return START_STICKY
    }

    private fun startPeriodicNotifications() {
        if (runnable != null) handler.removeCallbacks(runnable!!)
        
        runnable = object : Runnable {
            override fun run() {
                showRandomAdkar()
                handler.postDelayed(this, repeatInterval)
            }
        }
        handler.post(runnable!!)
    }

    private fun showRandomAdkar() {
        val prefs = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
        val textSize = prefs.getFloat("flutter.overlay_text_size", 18f)
        val textColor = prefs.getInt("flutter.overlay_text_color", Color.BLACK)
        val backgroundColor = prefs.getInt("flutter.overlay_background_color", Color.WHITE)
        val opacity = prefs.getFloat("flutter.overlay_background_opacity", 1.0f)
        
        val alpha = (opacity * 255).toInt()
        val finalBgColor = (alpha shl 24) or (backgroundColor and 0x00FFFFFF)
        
        val randomAdkar = adkarList.random()
        showOverlay(randomAdkar, textSize, textColor, finalBgColor)
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "تنبيهات الأذكار العائمة",
                NotificationManager.IMPORTANCE_LOW
            ).apply {
                description = "قناة لخدمة عرض الأذكار العائمة"
                setShowBadge(false)
            }
            val notificationManager = getSystemService(NotificationManager::class.java)
            notificationManager.createNotificationChannel(channel)
        }
    }

    private fun createNotification(): Notification {
        val notificationIntent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(
            this, 0, notificationIntent,
            PendingIntent.FLAG_IMMUTABLE
        )

        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("تطبيق الأذكار")
            .setContentText("يعمل في الخلفية")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentIntent(pendingIntent)
            .setOngoing(true)
            .setPriority(NotificationCompat.PRIORITY_MIN)
            .setSilent(true)
            .build()
    }

    private fun showOverlay(adkarText: String, textSize: Float, textColor: Int, backgroundColor: Int) {
        if (overlayView != null) {
            try {
                windowManager?.removeView(overlayView)
            } catch (e: Exception) {
                e.printStackTrace()
            }
            overlayView = null
        }

        windowManager = getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val inflater = getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
        overlayView = inflater.inflate(R.layout.overlay_notification, null)

        updateOverlayStyle(textSize, textColor, backgroundColor)
        
        val textView = overlayView?.findViewById<TextView>(R.id.adkar_text)
        textView?.text = adkarText

        val cardView = overlayView?.findViewById<View>(R.id.overlay_card)
        cardView?.setOnClickListener {
            removeOverlay()
        }

        val layoutFlag = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
        } else {
            @Suppress("DEPRECATION")
            WindowManager.LayoutParams.TYPE_PHONE
        }

        val params = WindowManager.LayoutParams(
            WindowManager.LayoutParams.MATCH_PARENT,
            WindowManager.LayoutParams.WRAP_CONTENT,
            layoutFlag,
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
                    WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN or
                    WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
            PixelFormat.TRANSLUCENT
        )

        params.gravity = Gravity.TOP or Gravity.CENTER_HORIZONTAL
        params.y = 100

        try {
            windowManager?.addView(overlayView, params)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }



    private fun updateOverlayStyle(textSize: Float, textColor: Int, backgroundColor: Int) {
        overlayView?.let { view ->
            val textView = view.findViewById<TextView>(R.id.adkar_text)
            textView?.textSize = textSize
            textView?.setTextColor(textColor)

            val cardView = view.findViewById<View>(R.id.overlay_card)
            val drawable = android.graphics.drawable.GradientDrawable()
            drawable.shape = android.graphics.drawable.GradientDrawable.RECTANGLE
            drawable.cornerRadius = 20f * resources.displayMetrics.density
            drawable.setColor(backgroundColor)
            drawable.setStroke(
                (0.5f * resources.displayMetrics.density).toInt(),
                android.graphics.Color.parseColor("#E0E0E0")
            )
            cardView?.background = drawable

            // Update layout if needed (e.g. for wrap_content)
            if (view.isAttachedToWindow) {
                try {
                    windowManager?.updateViewLayout(view, view.layoutParams)
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        }
    }

    private fun removeOverlay() {
        if (overlayView != null) {
            try {
                windowManager?.removeView(overlayView)
                overlayView = null
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        if (runnable != null) handler.removeCallbacks(runnable!!)
        removeOverlay()
        stopForeground(true)
    }
}
